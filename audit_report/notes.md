# Sturdy Audit

## **Overview**

[Docs](https://docs.sturdy.finance/overview/what-is-sturdy)

- Lenders deposit stablecoins to earn yield(ineterest)
- Borrowers provide collateral (eth/curve lp tokens) to take out a loan
- The collateral is staked in 3rd party protocols (Yearn, Lido, and Convex) to earn yield # Yearn=>Fantom
- The yield is periodically (every ~24 hours) distributed between borrowers and lenders
- For lenders, the yield is paid out in the same token that they deposited
- FOr borrowers, yield is paid out in form of yield token (CRV/CRX)
- When borrowers pay back their loan, their collateral is unstaked so that the deposited asset can be withdrawn

## **Funds at risk**

Collateral and lenders' stablecoins

## Inheritance graph

![Inheritance graph](./inheritance%20graph.png)

## Contracts

### GeneralVault

- This is a template for all vaults

### Lido Vault

- Used for depositing **ETH** as collateral and stake it in **Lido protocol**
- The deposited ETH is converted to stETH
- Borrowers can withdraw their collateral either as:
  - stETH, or
  - ETH via the Curve pool (the exchange rate is based on market conditions)
- Yield accrues via stETH **rebasing**
- yield = |deposited_eth - stETH|, this is swapped with eth & transferred to YieldManager.sol

### ConvexCurveLP Vault

- Used for depositing **Curve LP** tokens as collateral and stake them in **Convex**
- Mints an ERC20 token called \_internalToken
- \_internalToken gets deposited to LendingPool.sol, and is burned upon collateral withdrawal
- Yield accrues via CRV and CVX rewards from Convex staking
- The vault transfers all CRV and CVX rewards to YieldManager.sol, when harvested

### CollateralAdapter

- Returns the address of an internal asset from the address of an external asset
- This is used in LendingPool.sol's liquidation process

### YieldManager

- It receives tokens from vaults
- Swaps them to USDC via Uniswap
- USDC is swapped to stable coins via Curve
- Distribute them to lenders

## **Audit**

### GeneralVault

- initialize() **public** => @audit can it be maliciously called to change the addressProvider? **NO**
- depositCollateral(address \_asset, uint256 \_amount) **external** payable

  1. \_depositToYieldPool() will be called

     1. This will deposit the asset and give stAsset in return. Note: The vault should be able to handle both ETH/tokens
     2. The functionality will be further seen in Lido and Convex
     3. @audit how does the \_depositToYieldPool function handle ETH?

  2. If the \_depositToYieldPool() is successful, the stAsset will be deposited in the lending pool and the user will get aToken (interest bearing token)

- withdrawCollateral(address \_asset, uint256 \_amount, address \_to) **external**

  1. call \_getWithdrawalAmount to get the stAsset address and amount
  2. Withdraw from the lending pool to get stAsset
  3. \_withdrawFromYieldPool will transfer either ETH or stETH to user
  4. validates the withdrawal amount

- setTreasuryInfo(address \_treasury, uint256 \_fee) external onlyAdmin
  - sets treasury and vault fee
- \_getYield(address \_stAsset) internal
  - returns the accrued yield
- \_getYieldAmount(address \_stAsset) internal **view**
  - returns the amount of yield
- \_getAssetYields(uint256 \_WETHAmount) internal **view**
  - Get the list of asset and asset's yield amount
- \_depositYield(address \_asset, uint256 \_amount) internal
- withdrawOnLiquidation(), processYield(), pricePerShare(), \_depositToYieldPool, \_withdrawFromYieldPool, \_getWithdrawalAmount
  - not implemented

### LidoVault is GeneralVault

- \_processTreasury
  - moves yield to treasury as per the vault fee
- processYield() **external** override onlyAdmin
  1. gets the yield from lending pool => stEth
  2. moves yield to treasury depending on fee
  3. Exchange stETH -> ETH via Curve
  4. converts ETH to WETH
  5. transfer WETH to yieldManager
- \_depositToYieldPool(address \_asset,uint256 \_amount) internal override
  1. **It is called by depositCollateral()**
  2. if(\_asset = address(0)), then ETH will be deposited in Lido and stETH will be received
  3. if(\_asset = address(stETH)) then the token will be deposited
  4. approve lending pool to transfer stETH
- \_withdrawFromYieldPool(address \_asset,uint256 \_amount, address \_to) internal override
  1. **It is called by withdrawCollateral**
  2. if(\_asset = address(0)), withdraws ETH @audit require should be before the return statement...Loss of user funds is possible
  3. else withdraws stEth
  4. returns amount withdrawn

### ConvexCurveLPVault is GeneralVault

- setConfiguration()
- \_processTreasury

  - moves yield to treasury as per the vault fee

- \_transferYield(address \_asset) internal

  1. get yield amount
  2. transfers the yield to treasure according to the vault fee
  3. Transfers the remaining amount to Yield Manager

- processYield() **external** override onlyAdmin

  1. claims rewards from convex
  2. Transfer CRV to yield manager
  3. Transfer CVX to yield manager
  4. Transfer extra incentive token to yield manager

- \_depositToYieldPool(address \_asset,uint256 \_amount) internal override

  1. **It is called by depositCollateral()**
  2. @audit if user sends ETH with the call, the funds will be lost because depositCollateral() is payable
  3. receives CurveLP tokens from user
  4. these tokens are then deposited to Convex
  5. Mints and approves an internal token in the vault (amount = deposit_amount)

- \_withdraw(uint256 \_amount, address \_to) internal

  1. Withdraw tokens from convex
  2. transfer tokens to the address \_to
  3. burns the internal tokens equivalent to \_amount

- withdrawOnLiquidation(address \_asset, uint256 \_amount) **external** override

  1. require(\_asset == curveLPToken)
  2. require(msg.sender == lendingPool) @audit what if the lendingPool address is manipulated somehow? **Not possible**
  3. withdraws amount to msg.sender

- \_withdrawFromYieldPool(address \_asset,uint256 \_amount, address \_to) internal override
  1. **It is called by withdrawCollateral**
  2. withdraws tokens by calling \_withdraw()

### CollateralAdapter

- Admin can add a collateral asset

### YieldManager

- All non-payable functions can be called by admin only
