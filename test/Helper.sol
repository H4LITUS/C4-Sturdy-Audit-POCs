// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import { LendingPoolAddressesProvider } from
    "../src/protocol/configuration/LendingPoolAddressesProvider.sol";
import { LendingPool, DataTypes } from "../src/protocol/lendingpool/LendingPool.sol";
import { LidoVault } from "../src/protocol/vault/ethereum/LidoVault.sol";
import { ConvexCurveLPVault } from
    "../src/protocol/vault/ethereum/ConvexVault/ConvexCurveLPVault.sol";

import { ATokenForCollateral } from "../src/protocol/tokenization/ATokenForCollateral.sol";
import { StableDebtToken } from "../src/protocol/tokenization/StableDebtToken.sol";
import { VariableDebtToken } from "../src/protocol/tokenization/VariableDebtToken.sol";

import { IERC20 } from "../src/dependencies/openzeppelin/contracts/IERC20.sol";
import { ERC20 } from "../src/dependencies/openzeppelin/contracts/ERC20.sol";
import { IERC20Detailed } from "../src/dependencies/openzeppelin/contracts/IERC20Detailed.sol";
import { ILido } from "../src/interfaces/ILido.sol";
import { ISturdyIncentivesController } from "../src/interfaces/ISturdyIncentivesController.sol";
import { LendingPoolConfigurator } from "../src/protocol/lendingpool/LendingPoolConfigurator.sol";
import { ILendingPoolConfigurator } from "../src/interfaces/ILendingPoolConfigurator.sol";
import { ILido } from "../src/interfaces/ILido.sol";
import { IConvexBooster } from "../src/interfaces/IConvexBooster.sol";

import { YieldManager } from "../src/protocol/vault/YieldManager.sol";
import { DefaultReserveInterestRateStrategy } from
    "../src/protocol/lendingpool/DefaultReserveInterestRateStrategy.sol";

import { LendingRateOracle } from "../src/mocks/oracle/LendingRateOracle.sol";
import { PriceOracle } from "../src/mocks/oracle/PriceOracle.sol";

interface IConvexBaseRewardPool {
    function userRewardPerTokenPaid(address account) external view returns (uint256);

    function rewardPerToken() external view returns (uint256);

    function earned(address account) external view returns (uint256);

    function withdrawAndUnwrap(uint256 amount, bool claim) external;

    function getReward(address _account, bool _claimExtras) external;

    function getReward() external;

    function rewardToken() external view returns (address);

    function extraRewardsLength() external view returns (uint256);

    function extraRewards(uint256) external view returns (address);

    function rewardManager() external view returns (address);

    function addExtraReward(address _reward) external returns (bool);

    function queueNewRewards(uint256 _rewards) external returns (bool);
}

interface ILpToken {
    function minter() external view returns (address);
    function mint(address _to, uint256 _amount) external returns (bool);
}

contract WalletRejectETH {
// rejetcs ETH
}

contract ExtraReward {
    address public rewardToken;

    function getReward(address) external { }

    function addExtraReward(address _reward) external {
        rewardToken = _reward;
    }
}

contract RewardToken_HeavyGasUsge is ERC20 {
    constructor() public ERC20("RewardToken", "RTK") {
        _mint(msg.sender, 100_000 ether);
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        for (uint256 i = 0; i < 10; i++) {
            new ConvexCurveLPVault();
        }
        return true;
    }
}

contract RewardToken_RevertsOnZeroTransfer is ERC20 {
    constructor() public ERC20("RewardToken", "RTK") {
        _mint(msg.sender, 100_000 ether);
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        require(amount > 0, "Amount is zero");
        super.transfer(recipient, amount);
        return true;
    }
}

contract Helper {
    // https://curve.readthedocs.io/ref-addresses.html
    // address lpToken = 0xFd2a8fA60Abd58Efe3EeE34dd494cD491dC14900; // poolId=24
    address lpToken = 0x06325440D014e39736583c165C2963BA99fAf14E; // poolId=25
    uint256 poolId = 25;

    // Lido-stEth mainnet address from https://docs.lido.fi/deployed-contracts/
    address constant stETHAddress = 0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84;

    // addresses from mainnet and the sturdy hardhat github repo
    address constant CURVE_ADDRESS_PROVIDER = 0x0000000022D53366457F9d5E68Ec105046FC4383;
    address constant STETH_ETH_POOL = 0xDC24316b9AE028F1497c275EB9192a3Ea0f67022;
    address constant CRV_ADDRESS = 0xD533a949740bb3306d119CC777fa900bA034cd52;
    address constant CVX_ADDRESS = 0x4e3FBD56CD56c3e72c1403e103b45Db9da5B9D2B;
    address constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    address constant UNISWAP_ROUTER_ADDRESS = 0xE592427A0AEce92De3Edee1F18E0157C05861564;
    address constant USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    address constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;

    IConvexBooster internal convexBooster =
        IConvexBooster(0xF403C135812408BFbE8713b5A23a04b3D48AAE31);

    address internal stETHaTokenProxyAddress;
    address internal lpTokenATokenProxyAddress;

    LendingPoolAddressesProvider internal lendingPoolAddressesProvider;
    address internal lendingPoolProxyAddress;

    LidoVault internal lidoVault;
    ConvexCurveLPVault internal convexVault;

    ATokenForCollateral internal stETHaToken;
    StableDebtToken internal stETHstableDebtToken;
    VariableDebtToken internal stETHvariableDebtToken;

    ATokenForCollateral internal lpTokenAToken;
    StableDebtToken internal lpTokenStableDebtToken;
    VariableDebtToken internal lpTokenVariableDebtToken;

    LendingPoolConfigurator internal lendingPoolConfigurator;
    ILendingPoolConfigurator.InitReserveInput[] internal input;

    YieldManager internal yieldManager;
    DefaultReserveInterestRateStrategy internal defaultReserveInterestRateStrategy;

    LendingRateOracle internal lendingRateOracle;
    PriceOracle internal priceOracle;

    function sturdyDeploymentAndSetup() public virtual {
        // Deploy Lending pool and Set up Lending pool addresses provider
        setUpLendingPoolAddressesProvider();

        // deploy Yield Manager
        yieldManager = new YieldManager();
        lendingPoolAddressesProvider.setAddress("YIELD_MANAGER", address(yieldManager));
        yieldManager.initialize(lendingPoolAddressesProvider);
        yieldManager.setExchangeToken(DAI);

        // deploy DefaultReserveInterestRateStrategy
        defaultReserveInterestRateStrategy =
        new DefaultReserveInterestRateStrategy(lendingPoolAddressesProvider, 45*10**25,0,0,0,0,0);

        deployOracles();
        deployVaults();
        deployMockTokens();

        /*  initialize a reserve for stEth/LpToken
            and 
            reserve aToken/StableDebtTokens/VariableDebtToken in Lending Pool 
        */
        input.push(
            ILendingPoolConfigurator.InitReserveInput(
                address(stETHaToken),
                address(stETHstableDebtToken),
                address(stETHvariableDebtToken),
                18,
                address(defaultReserveInterestRateStrategy),
                stETHAddress,
                address(0),
                address(yieldManager),
                address(0),
                "stETH",
                "stETHaToken",
                "ATK",
                "stETHvariableToken",
                "VTK",
                "stETHstableToken",
                "STK",
                ""
            )
        );

        input.push(
            ILendingPoolConfigurator.InitReserveInput(
                address(lpTokenAToken),
                address(lpTokenStableDebtToken),
                address(lpTokenVariableDebtToken),
                18,
                address(defaultReserveInterestRateStrategy),
                convexVault.getInternalAsset(),
                address(0),
                address(yieldManager),
                address(0),
                "Curve.fi aDAI/aUSDC/aUSDT",
                "LpTokenAToken",
                "ATK",
                "LpTokenVariableToken",
                "VTK",
                "LpTokenStableToken",
                "STK",
                ""
            )
        );

        // deploys and initializes proxy contract of all 3 tokens
        lendingPoolConfigurator.batchInitReserve(input);

        // get aTokenProxy address for both reserves
        DataTypes.ReserveData memory reserves =
            LendingPool(lendingPoolProxyAddress).getReserveData(stETHAddress);
        stETHaTokenProxyAddress = reserves.aTokenAddress;

        reserves =
            LendingPool(lendingPoolProxyAddress).getReserveData(convexVault.getInternalAsset());
        lpTokenATokenProxyAddress = reserves.aTokenAddress;

        // enables borrowing for both tokens
        // lendingPoolConfigurator.enableBorrowingOnReserve(stETHAddress, true);
        // lendingPoolConfigurator.enableBorrowingOnReserve(lpToken, true);

        // // This loop is to find the pool_id for a particulat lpToken
        // // The pool_id for the lpToken (Curve.fi aDAI/aUSDC/aUSDT) is 24
        // uint256 poolLength = convexBooster.poolLength();
        // for (uint256 i = 0; i < poolLength; i++) {
        //     IConvexBooster.PoolInfo memory info;
        //     info = convexBooster.poolInfo(i);
        //     if (info.lptoken == lpToken) {
        //         poolId = i;
        //         break;
        //     }
        // }
        // console.log("Pool ID: %s", poolId);
    }

    function setUpLendingPoolAddressesProvider() internal {
        // deploy lendingAddressesProvider
        lendingPoolAddressesProvider = new LendingPoolAddressesProvider("Sturdy genesis market");

        // deploy, initialize, and set LendingPool in lendingAddressesProvider
        LendingPool lendingPool = new LendingPool();
        // lendingPool.initialize(lendingPoolAddressesProvider);
        lendingPoolAddressesProvider.setLendingPoolImpl(address(lendingPool));
        lendingPoolProxyAddress = lendingPoolAddressesProvider.getLendingPool();

        // deploy, initialize, and set LendingPoolConfigurator in lendingAddressesProvider
        lendingPoolConfigurator = new LendingPoolConfigurator();
        lendingPoolAddressesProvider.setLendingPoolConfiguratorImpl(
            address(lendingPoolConfigurator)
        );
        lendingPoolConfigurator =
            LendingPoolConfigurator(lendingPoolAddressesProvider.getLendingPoolConfigurator());

        // set required addresses from mainnet in lendingPoolAddressesProvider
        lendingPoolAddressesProvider.setAddress("LIDO", stETHAddress);
        lendingPoolAddressesProvider.setAddress("CURVE_ADDRESS_PROVIDER", CURVE_ADDRESS_PROVIDER);
        lendingPoolAddressesProvider.setAddress("STETH_ETH_POOL", STETH_ETH_POOL);
        lendingPoolAddressesProvider.setAddress("WETH", WETH);
        lendingPoolAddressesProvider.setAddress("uniswapRouter", UNISWAP_ROUTER_ADDRESS);

        lendingPoolAddressesProvider.setAddress("CRV", CRV_ADDRESS);
        lendingPoolAddressesProvider.setAddress("CVX", CVX_ADDRESS);

        // set pool admin
        lendingPoolAddressesProvider.setPoolAdmin(address(this));
    }

    function deployOracles() internal {
        // deploy and set up lendingRateOracle
        lendingRateOracle = new LendingRateOracle();
        lendingRateOracle.setMarketBorrowRate(stETHAddress, 1);
        lendingRateOracle.setMarketLiquidityRate(stETHAddress, 1);
        // set LendingRateOracle address in addressesProvider
        lendingPoolAddressesProvider.setLendingRateOracle(address(lendingRateOracle));

        // deploy PriceOracle
        priceOracle = new PriceOracle();

        // set price of assets in the Price Oracle
        priceOracle.setAssetPrice(stETHAddress, 1);
        priceOracle.setAssetPrice(WETH, 1);
        priceOracle.setAssetPrice(USDC, 1);
        priceOracle.setAssetPrice(DAI, 1);
        priceOracle.setAssetPrice(lpToken, 1);

        priceOracle.setEthUsdPrice(1);

        // set priceOracle address in addressesProvider
        lendingPoolAddressesProvider.setPriceOracle(address(priceOracle));
    }

    function deployVaults() internal {
        // deploy LidoVault
        lidoVault = new LidoVault();
        lidoVault.initialize(lendingPoolAddressesProvider);

        // deploy ConvexCurveLPVault
        convexVault = new ConvexCurveLPVault();
        convexVault.initialize(lendingPoolAddressesProvider);

        convexVault.setConfiguration(lpToken, poolId);

        // register vaults with lending pool
        lendingPoolConfigurator.registerVault(address(lidoVault));
        lendingPoolConfigurator.registerVault(address(convexVault));
    }

    function deployMockTokens() internal {
        //deploy mock tokens for stEth asset and lending pool (LidoVault)
        stETHaToken = new ATokenForCollateral();
        stETHstableDebtToken = new StableDebtToken();
        stETHvariableDebtToken = new VariableDebtToken();

        //deploy mock tokens for lpToken asset and lending pool (ConvexVault)
        lpTokenAToken = new ATokenForCollateral();
        lpTokenStableDebtToken = new StableDebtToken();
        lpTokenVariableDebtToken = new VariableDebtToken();
    }
}
