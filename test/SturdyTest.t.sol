// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

// import { console2 } from "forge-std/console2.sol";
import "forge-std/Test.sol";
import "forge-std/Vm.sol";
import "./Helper.sol";

contract SturdyTest is Test, Helper {
    address alice;
    address bob;

    function setUp() public virtual {
        // To use the forked mainnet on localhost
        vm.createSelectFork({ urlOrAlias: "localhost" });

        // get private keys using mnemonic
        string memory mnemonic = vm.envString("MNEMONIC_LOCALHOST");
        (alice,) = deriveRememberKey(mnemonic, 0);
        (bob,) = deriveRememberKey(mnemonic, 1);

        sturdyDeploymentAndSetup();
    }

    function test_LidoVault_depositsAndWithdraws() external {
        uint256 deposit_amount = 1000;

        //test
        vm.startPrank(alice);
        uint256 lido_ethBalanceBeforeDeposit = address(stETHAddress).balance;

        // deposit eth to lido vault
        lidoVault.depositCollateral{ value: deposit_amount }(address(0), deposit_amount);

        // balances after deposit
        uint256 lido_ethBalanceAfterDeposit = address(stETHAddress).balance;
        uint256 stEthBalanceAfterDeposit = ILido(stETHAddress).balanceOf(stETHaTokenProxyAddress);
        uint256 aTokenBalanceAfterDeposit =
            ATokenForCollateral(stETHaTokenProxyAddress).balanceOf(alice);

        // withdraw
        uint256 alice_ethBalanceBeforeWithdraw = alice.balance;
        lidoVault.withdrawCollateral(address(0), 999, alice);
        uint256 alice_ethBalanceAfterWithdraw = alice.balance;
        vm.stopPrank();
        console.log(
            "Balance increase after withdraw: %d",
            alice_ethBalanceAfterWithdraw - alice_ethBalanceBeforeWithdraw
        );

        // deposits successfully
        assertEq(aTokenBalanceAfterDeposit, deposit_amount);
        assertEq(lido_ethBalanceAfterDeposit, lido_ethBalanceBeforeDeposit + deposit_amount);
        assertEq(stEthBalanceAfterDeposit, deposit_amount - 1);

        // withdraws successfully
        assertGt(alice_ethBalanceAfterWithdraw, alice_ethBalanceBeforeWithdraw);
    }

    function test_H2_LidoVault_withdrawWithoutReceivingEth() external {
        uint256 deposit_amount = 1000;
        vm.startPrank(alice);
        // deposit eth to lido vault
        lidoVault.depositCollateral{ value: deposit_amount }(address(0), deposit_amount);

        // withdrawals will be transferred to this wallet, however, it shoudl reject it
        WalletRejectETH wallet = new WalletRejectETH();

        uint256 alice_aTokenBalanceBeforeWithdrawal =
            ATokenForCollateral(stETHaTokenProxyAddress).balanceOf(alice);

        uint256 wallet_ethBalanceBeforeWithdraw = address(wallet).balance;
        // withdraw collateral
        lidoVault.withdrawCollateral(address(0), deposit_amount, address(wallet));
        vm.stopPrank();

        uint256 wallet_ethBalanceAfterWithdraw = address(wallet).balance;
        uint256 alice_aTokenBalanceAfterWithdrawal =
            ATokenForCollateral(stETHaTokenProxyAddress).balanceOf(alice);

        // successfully deposits
        assertEq(alice_aTokenBalanceBeforeWithdrawal, deposit_amount);
        // withdraws aTokens
        assertEq(alice_aTokenBalanceAfterWithdrawal, 0);
        // does not receive any ETH that was deposited
        assertEq(wallet_ethBalanceAfterWithdraw, wallet_ethBalanceBeforeWithdraw);
    }

    function test_M1_LidoVault_lostMsgValue() external {
        uint256 deposit_amount = 1000;

        // address from mainnet with tokens
        alice = 0x4C49d4Bd6a571827B4A556a0e1e3071DA6231B9D;
        vm.startPrank(alice);
        // approve vault for stEth
        ILido(stETHAddress).approve(address(lidoVault), deposit_amount);

        // deposit stEth to lido vault
        uint256 alice_ethBalanceBeforeDeposit = alice.balance;
        lidoVault.depositCollateral{ value: deposit_amount }(stETHAddress, deposit_amount);

        uint256 alice_ethBalanceAfterDeposit = alice.balance;
        uint256 alice_stEthBalanceBeforeWithdraw = ILido(stETHAddress).balanceOf(alice);

        // withdraw collateral
        lidoVault.withdrawCollateral(stETHAddress, deposit_amount, alice);
        vm.stopPrank();

        uint256 alice_stEthBalanceAfterWithdraw = ILido(stETHAddress).balanceOf(alice);
        uint256 alice_ethBalanceAfterWithdraw = alice.balance;
        uint256 alice_aTokenBalanceAfterWithdrawal =
            ATokenForCollateral(stETHaTokenProxyAddress).balanceOf(alice);

        // ETH transferred to vault along with stETh
        assertEq(alice_ethBalanceAfterDeposit, alice_ethBalanceBeforeDeposit - deposit_amount);

        // aTokens withdrawed
        assertEq(alice_aTokenBalanceAfterWithdrawal, 0);

        // stEth received after withdrawal
        assertEq(
            alice_stEthBalanceAfterWithdraw, alice_stEthBalanceBeforeWithdraw + deposit_amount - 1
        );

        // No eth received after withdrawal (1000 wei was deposited earlier)
        assertEq(alice_ethBalanceAfterDeposit, alice_ethBalanceAfterWithdraw);
    }

    function test_M1_ConvexVault_lostMsgValue() external {
        uint256 deposit_amount = 1000;

        vm.prank(ILpToken(lpToken).minter());
        ILpToken(lpToken).mint(alice, 1000);
        // assertEq(IERC20(lpToken).balanceOf(alice), 1_000_000);

        vm.startPrank(alice);
        // approve vault for lpToken
        IERC20(lpToken).approve(address(convexVault), deposit_amount);

        uint256 alice_ethBalanceBeforeDeposit = alice.balance;
        // deposit lpToken to Convex vault
        convexVault.depositCollateral{ value: deposit_amount }(lpToken, deposit_amount);
        uint256 alice_ethBalanceAfterDeposit = alice.balance;

        uint256 alice_lpTokenBalanceBeforeWithdrawl = IERC20(lpToken).balanceOf(alice);
        // withdraw collateral
        convexVault.withdrawCollateral(lpToken, deposit_amount, alice);

        uint256 alice_lpTokenBalanceAfterWithdraw = IERC20(lpToken).balanceOf(alice);
        uint256 alice_ethBalanceAfterWithdraw = alice.balance;
        vm.stopPrank();

        uint256 alice_aTokenBalanceAfterWithdrawal =
            IERC20(lpTokenATokenProxyAddress).balanceOf(alice);

        // ETH transferred to vault along with LP Token
        assertEq(alice_ethBalanceAfterDeposit, alice_ethBalanceBeforeDeposit - deposit_amount);

        // aTokens withdrawed
        assertEq(alice_aTokenBalanceAfterWithdrawal, 0);

        // lpToken received after withdrawal
        assertEq(
            alice_lpTokenBalanceAfterWithdraw, alice_lpTokenBalanceBeforeWithdrawl + deposit_amount
        );

        // No eth received after withdrawal (1000 wei was deposited earlier)
        assertEq(alice_ethBalanceAfterDeposit, alice_ethBalanceAfterWithdraw);
    }

    function test_M3_transferYield_reverts_with_long_list_of_extra_rewards() external {
        uint256 deposit_amount = 1 ether;

        vm.prank(ILpToken(lpToken).minter());
        ILpToken(lpToken).mint(alice, deposit_amount);

        vm.startPrank(alice);
        // approve vault for lpToken
        IERC20(lpToken).approve(address(convexVault), deposit_amount);

        // deposit lpToken to Convex vault
        convexVault.depositCollateral{ value: deposit_amount }(lpToken, deposit_amount);
        vm.stopPrank();

        // add extra rewards
        IConvexBooster.PoolInfo memory poolInfo = convexBooster.poolInfo(poolId);
        address extraRewards = poolInfo.crvRewards;
        IConvexBaseRewardPool rewardPool = IConvexBaseRewardPool(extraRewards);

        for (uint256 i = 0; i < 5; i++) {
            RewardToken_HeavyGasUsge rewardToken = new RewardToken_HeavyGasUsge();
            ExtraReward extraReward = new ExtraReward();
            extraReward.addExtraReward(address(rewardToken));
            address rewardManager = rewardPool.rewardManager();

            vm.prank(rewardManager);
            bool success = rewardPool.addExtraReward(address(extraReward));
            require(success, "Failed to add extra rewards");
        }

        // transaction will run out of gas due to high gas usage during transfer of extra rewards
        vm.expectRevert();
        convexVault.processYield{ gas: 400_000 }();
    }

    function test_M4_transferYield_stuck_with_zero_reward_transfer() external {
        uint256 deposit_amount = 1 ether;

        vm.prank(ILpToken(lpToken).minter());
        ILpToken(lpToken).mint(alice, deposit_amount);

        vm.startPrank(alice);
        // approve vault for lpToken
        IERC20(lpToken).approve(address(convexVault), deposit_amount);

        // deposit lpToken to Convex vault
        convexVault.depositCollateral{ value: deposit_amount }(lpToken, deposit_amount);
        vm.stopPrank();

        // add extra reward (this token reverts on transfer if amount=0)
        IConvexBooster.PoolInfo memory poolInfo = convexBooster.poolInfo(poolId);
        address extraRewards = poolInfo.crvRewards;
        IConvexBaseRewardPool rewardPool = IConvexBaseRewardPool(extraRewards);

        RewardToken_RevertsOnZeroTransfer rewardToken = new RewardToken_RevertsOnZeroTransfer();
        ExtraReward extraReward = new ExtraReward();
        extraReward.addExtraReward(address(rewardToken));
        address rewardManager = rewardPool.rewardManager();

        vm.prank(rewardManager);
        bool success = rewardPool.addExtraReward(address(extraReward));
        require(success, "Failed to add extra rewards");

        // since the yeild=0, the extra reward token should revert due to transfer of 0 tokens
        vm.expectRevert();
        convexVault.processYield();
    }

    function test_M5_LidoVault_withdrawFailsWithMaxAmount() external {
        uint256 _amount = type(uint256).max;
        address _asset = address(0);

        vm.expectRevert();
        // GeneralVault.sol#L121-L124
        // https://github.com/code-423n4/2022-05-sturdy/blob/78f51a7a74ebe8adfd055bdbaedfddc05632566f/smart-contracts/GeneralVault.sol#L121-L124
        if (_amount == type(uint256).max) {
            uint256 decimal = IERC20Detailed(_asset).decimals();
        }
    }

    function test_M6_yield_unfair_distribution() external {
        uint256 deposit_amount = 100_000_000_000;
        vm.prank(ILpToken(lpToken).minter());
        ILpToken(lpToken).mint(bob, deposit_amount);

        vm.startPrank(bob);
        // approve vault for lpToken
        IERC20(lpToken).approve(address(convexVault), deposit_amount);
        // deposit lpToken to Convex vault
        convexVault.depositCollateral(lpToken, deposit_amount);
        vm.stopPrank();

        uint256 crv_yieldManagerBefore = IERC20(CRV_ADDRESS).balanceOf(address(yieldManager));
        uint256 cvx_yieldManagerBefore = IERC20(CRV_ADDRESS).balanceOf(address(yieldManager));

        // to simulate yield of convexVault
        vm.warp(block.timestamp + 100_000);
        convexVault.processYield();

        // check balances
        uint256 crv_yieldManagerAfter = IERC20(CRV_ADDRESS).balanceOf(address(yieldManager));
        uint256 cvx_yieldManagerAfter = IERC20(CRV_ADDRESS).balanceOf(address(yieldManager));

        console.log(
            "CRV balance before/after processing yield: %s / %s",
            crv_yieldManagerBefore,
            crv_yieldManagerAfter
        );
        console.log(
            "CVX balance before/after processing yield: %s / %s",
            cvx_yieldManagerBefore,
            cvx_yieldManagerAfter
        );

        // hacker deposits stETH in lidoVault before processing Yield
        alice = 0x4C49d4Bd6a571827B4A556a0e1e3071DA6231B9D;
        deposit_amount = 2 ether;
        vm.startPrank(alice);
        // approve vault for stEth transfer
        ILido(stETHAddress).approve(address(lidoVault), deposit_amount);

        // deposit stEth to lido vault
        lidoVault.depositCollateral(stETHAddress, deposit_amount);
        vm.stopPrank();

        // transfer some stETh to stEthAToken so simulate yield in lending pool
        vm.prank(alice);
        ILido(stETHAddress).transfer(stETHaTokenProxyAddress, deposit_amount);

        // processYield - transfer to Yield Manager
        uint256 weth_yieldManagerBefore = IERC20(WETH).balanceOf(address(yieldManager));
        lidoVault.processYield();
        uint256 weth_yieldManagerAfter = IERC20(WETH).balanceOf(address(yieldManager));

        assertTrue(weth_yieldManagerAfter > weth_yieldManagerBefore);

        console.log(
            "WETH balance of Yield Manager before/after processing yield: %s / %s",
            weth_yieldManagerBefore,
            weth_yieldManagerAfter
        );

        // register assets with yield manager
        yieldManager.registerAsset(WETH);
        yieldManager.registerAsset(CRV_ADDRESS);
        yieldManager.registerAsset(CVX_ADDRESS);

        // yieldManager.setCurvePool(WETH, stETHAddress,
        // 0x828b154032950C8ff7CF8085D841723Db2696056);

        // distribute yeild
        uint256 dai_yieldManagerBefore = IERC20(DAI).balanceOf(address(yieldManager));
        yieldManager.distributeYield(0, 1);
        uint256 dai_yieldManagerAfter = IERC20(DAI).balanceOf(address(yieldManager));

        console.log(
            "DAI balance of Yield Manager before/after distributing yield: %s / %s",
            dai_yieldManagerBefore,
            dai_yieldManagerAfter
        );

        // 17380967
        // 3663318849987590120804
    }
}
