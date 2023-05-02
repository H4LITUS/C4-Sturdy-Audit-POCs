# High Risk Findings (2)

## [H-01] Hard-coded slippage may freeze user funds during market turbulence

[GeneralVault.sol#L125](https://github.com/code-423n4/2022-05-sturdy/blob/78f51a7a74ebe8adfd055bdbaedfddc05632566f/smart-contracts/GeneralVault.sol#L125)<br>
[LidoVault.sol#L130-L137](https://github.com/code-423n4/2022-05-sturdy/blob/main/smart-contracts/LidoVault.sol#L130-L137)

I didn't had knowledge about slippage, however I should have considered the following possibilities.

Questions:

1. This is a require statement at the end of withdraw function. If this reverts then the withdrawal will fail?
2. How can it revert?
3. Is there a possibility that it will revert everytime, or maybe under some condition that will result in user funds being locked?
4. If there is a possiblity of the user funds getting locked, what are the mitigation steps?

## [H-02] The check for value transfer success is made after the return statement in \_withdrawFromYieldPool of LidoVault

[LidoVault.sol#L142](https://github.com/code-423n4/2022-05-sturdy/blob/78f51a7a74ebe8adfd055bdbaedfddc05632566f/smart-contracts/LidoVault.sol#L142)

I found this one xD

# Medium Risk Findings (6)

## [M-01] Possible lost msg.value

I have found this one as well XD
But I have a confilict with the finding in the report. It's stated in the report that

> Also in [LidoVault](https://github.com/code-423n4/2022-05-sturdy/blob/78f51a7a74ebe8adfd055bdbaedfddc05632566f/smart-contracts/LidoVault.sol#L79-L104), Check if the msg.value is equeal to \_amount when the \_asset ETH(== address(0))

There is no need to check this because in [LidoVault.sol#L94](https://github.com/code-423n4/2022-05-sturdy/blob/78f51a7a74ebe8adfd055bdbaedfddc05632566f/smart-contracts/LidoVault.sol#L94), the assetAmount is set to msg.value

## [M-02] UNISWAP_FEE is hardcoded which will lead to significant losses compared to optimal routing

The function **distributeYield** [YieldManager.sol#L118--L137](https://github.com/code-423n4/2022-05-sturdy/blob/78f51a7a74ebe8adfd055bdbaedfddc05632566f/smart-contracts/YieldManager.sol#L118--L137) can be called by admin only so i didn't give it much thought that there could be a vulnerability here. This calls \_convertAssetToExchangeToken [YieldManager.sol#L178-L187](https://github.com/code-423n4/2022-05-sturdy/blob/78f51a7a74ebe8adfd055bdbaedfddc05632566f/smart-contracts/YieldManager.sol#L178-L187) and the issue lies there as stated in the c4 report.

Questions:

1. The asset is converted to exhange token via Uniswap. How does this function work in Uniswap?
2. The parameters `UNISWAP_FEE` and `SLIPPAGE` are hardcoded. How are they used in the uniswap?

## [M-03] [processYield()#L105-L110](https://github.com/code-423n4/2022-05-sturdy/blob/78f51a7a74ebe8adfd055bdbaedfddc05632566f/smart-contracts/ConvexCurveLPVault.sol#L105-L110) and [distributeYield() #L129-L136](https://github.com/code-423n4/2022-05-sturdy/blob/78f51a7a74ebe8adfd055bdbaedfddc05632566f/smart-contracts/YieldManager.sol#L129-L136) may run out of gas and revert due to long list of extra rewards/yields

Questions:

1. A dynamic array is being looped. Is there a possibility that the array can be long and each iteration is gas expensive?

## [M-04] ConvexCurveLPVault’s [\_transferYield](https://github.com/code-423n4/2022-05-sturdy/blob/78f51a7a74ebe8adfd055bdbaedfddc05632566f/smart-contracts/ConvexCurveLPVault.sol#L74-L82) can become stuck with zero reward transfer

Questions:

1. In the transferYield function, is there a check for zero amount transfer of ERC20 tokens? Because some ERC20 tokens doesn't allow zero amount transfer and reverts?
2. Can the yields be stuck somehow in the contract? i.e. the contract reverts somehow? what are the odds?

## [M-05] Withdrawing ETH collateral with max uint256 amount value reverts transaction

[GeneralVault.sol#L121-L124](https://github.com/code-423n4/2022-05-sturdy/blob/78f51a7a74ebe8adfd055bdbaedfddc05632566f/smart-contracts/GeneralVault.sol#L121-L124)

Questions:

1. I should dry run the code for each possible input
2. What if the withdrawal in is ETH? How will each piece of this function work with ETH and ERC20 tokens individually?

## [M-06] Yield can be unfairly divided because of MEV/Just-in-time stablecoin deposits

[YieldManager.sol#L129-L134](https://github.com/code-423n4/2022-05-sturdy/blob/main/smart-contracts/YieldManager.sol#L129-L134)
[YieldManager.sol#L160-L161](https://github.com/code-423n4/2022-05-sturdy/blob/main/smart-contracts/YieldManager.sol#L160-L161)

Questions:

1. How is the yield divided amongst lenders?
2. Can an MEV/hacker somehow exploit this division functionality to get the maximum yield?

# POCs

- H-02
- M-01
- M-03
- M-04
- M-05
- M-06
