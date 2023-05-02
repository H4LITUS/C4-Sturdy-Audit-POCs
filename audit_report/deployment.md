%  
syedgulzarali@Syeds-MacBook-Pro code4rena-may-2022 % yarn sturdy:evm:fork:mainnet:migration
yarn run v1.22.19
warning package.json: License should be a valid SPDX license expression
warning ../../../../package.json: No license field
$ FORK=main hardhat sturdy:mainnet --network localhost

- Enviroment
  - Fork Mode activated at network: main
  - Provider URL: eth-mainnet.alchemyapi.io
  - Network : localhost
    Migration started

1. Deploy address provider
   **_ LendingPoolAddressesProvider _**

Network: localhost
tx: 0x10b190c2100037f34bed885ced9c0846a58e191b8818350126554ca0c2320046
contract address: 0x3a5e7db2E0EA9e69fB53Cd8582e64D4001746E8c
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 1728820

---

- Deploying a new Address Providers Registry:
  Signer 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
  Balance 999999.98616944
  **_ LendingPoolAddressesProviderRegistry _**

Network: localhost
tx: 0xa77d22e1722703d660e25de2e2736c96ea995268bdfad8483fc88b0a691bbcbc
contract address: 0xda87577f9eb8B15B26C00619FD06d4485880310D
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 543411

---

Deployed Registry Address: 0xda87577f9eb8B15B26C00619FD06d4485880310D
Added LendingPoolAddressesProvider with address "0x3a5e7db2E0EA9e69fB53Cd8582e64D4001746E8c" to registry located at 0xda87577f9eb8B15B26C00619FD06d4485880310D
Pool Admin 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
Emergency Admin 0x8401Eb5ff34cc943f096A32EF3d5113FEbE8D4Eb 2. Deploy lending pool
Deploying new lending pool implementation & libraries...
**_ ReserveLogic _**

Network: localhost
tx: 0x041890ec585023ee3b53a8fba0223c29faad40991bfa8bfeb51c568969631601
contract address: 0xA6f48C8190be8F92A4c31aAE4756289Ef3d91477
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 182669

---

**_ GenericLogic _**

Network: localhost
tx: 0x8956ac871802a68a3298a694775ba0d245de80ed111c221d2c188dd1a0138404
contract address: 0xa51d9BD713E0a812e5289D926F8f721eb1d71112
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 851914

---

**_ ValidationLogic _**

Network: localhost
tx: 0x6c02d6abe755054ec64693cbde2f013254059bbc33fb268937c0106d0774594b
contract address: 0x5aE47822Da849508020c25E2E92c4a4cC4E03001
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 2042841

---

**_ LendingPool _**

Network: localhost
tx: 0x116b25e7d57a0fccb3c03b8dd3c2193f15c4a5de2685a7fc58beeb5a48beaf82
contract address: 0x677B89Ac909215B7e6B6bA46e229eBCe08d25e79
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 4751532

---

        Setting lending pool implementation with address: 0x677B89Ac909215B7e6B6bA46e229eBCe08d25e79
        Deploying new configurator implementation...

**_ LendingPoolConfigurator _**

Network: localhost
tx: 0x1ec618835a530fdfc00e1ea6b097542f7c78c5bc833d53f980a3aa7fc4215660
contract address: 0xa222efa1133c6702a83eFD04bD5E7Ef941EDb2EC
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 3793086

---

        Setting lending pool configurator implementation with address: 0xa222efa1133c6702a83eFD04bD5E7Ef941EDb2EC

**_ StableAndVariableTokensHelper _**

Network: localhost
tx: 0xa25320967701e9818b4631191180c5b3824cd2472325f9f7fd7197f5d080232a
contract address: 0x3990b44d6233D8287c62635028FAc7b046c5607A
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 3699874

---

**_ ATokensAndRatesHelper _**

Network: localhost
tx: 0xd3a45335d065573bd97c8c914744cf59a554cff93f4de6b7a1a0d2c8cf7575b8
contract address: 0x58a749D6760e7dd926dF737Ec45b65F687aBbE52
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 3921094

---

3. Deploy oracles
   **_ SturdyOracle _**

Network: localhost
tx: 0xe846555745373411b4c3915a07c4d257e270f0fac5ae00b71eb6bc1da139140d
contract address: 0x2e9f55f7266d8C7e07d359daBA0e743e331B7A1A
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 811571

---

**_ LendingRateOracle _**

Network: localhost
tx: 0x021bf634cf1736508b5681be34ab5ecee09d13d1b0b1316738f9241c55aa628a
contract address: 0x609D79AD1935BB9aEce827B8eC111e87122928a7
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 345146

---

- Oracle borrow initalization in 1 txs
  - Setted Oracle Borrow Rates for: DAI, USDC
    Sturdy Oracle: 0x609D79AD1935BB9aEce827B8eC111e87122928a7
    Lending Rate Oracle: 0x609D79AD1935BB9aEce827B8eC111e87122928a7

4. Deploy Data Provider
   **_ SturdyProtocolDataProvider _**

Network: localhost
tx: 0xd54074663924e5cf88bd10fe0aff59fa133e14eeaacc0b9244b1bc0795ad5be2
contract address: 0x48c2Eac33521070509f9819A824a3D5686Ba5ce8
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 1653948

---

5. Deploy Incentives impl
   Duplicate definition of RewardsClaimed (RewardsClaimed(address,address,uint256), RewardsClaimed(address,address,address,uint256))
   **_ StakedTokenIncentivesControllerImpl _**

Network: localhost
tx: 0xb4e3e5a994e6d8973b978931b3ff8b95e5ea6b0e1a3cf1cd128501a3b345daba
contract address: 0x16cC86D9c42208eE9e22b377e3d7927630733a06
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 1748311

---

Duplicate definition of RewardsClaimed (RewardsClaimed(address,address,uint256), RewardsClaimed(address,address,address,uint256))

- Incentives proxy address 0xA897716BA0c7603B10b8b2854c104912a6058542
  **_ SturdyTokenImpl _**

Network: localhost
tx: 0xa21294366a6a4f49d3838842d8335525893e514ac68ab251a1d84d8b3478358a
contract address: 0x0f407B6532BB4092638Ad5CEd2b17BD34d521402
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 833969

---

- Incentives sturdy token proxy address 0x7Ff897A14796072a1d23e0002f3Dca9Bc80af677

6. Deploy Lido vault
   **_ LidoVaultImpl _**

Network: localhost
tx: 0x536ce0a04ec591fe2c6356ff37512132273a7c1921370690f83f29cb0894204c
contract address: 0x9310dC480CbF907D6A3c41eF2e33B09E61605531
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 1825380

---

LidoVault.address 0x1A4313DdE95487EAAbfF58A181fd34cbe3638041
Finished LidoVault deployment
6-1. Deploy Yearn RETH_WSTETH vault
**_ YearnRETHWstETHVaultImpl _**

Network: localhost
tx: 0x7027ba859b89224818ce6189ab5824569e51cb962e8b7a4b2622a174a6d0bf2a
contract address: 0x5f4e510503d83bd1a5436bDaE2923489dA0Be454
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 2277559

---

**_ RETHWstETHLPOracle _**

Network: localhost
tx: 0x1c2b5f2f6bff9bb3ea6cecd8664666877d4102b25afd382d7d78dc51adb11382
contract address: 0x2e25c8F88c5cCcbC9400e5bc86cF9C58C7604327
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 274947

---

993965357707900958
YearnRETHWstETHVault.address 0x8d58c3574A6D32F5F848Abe8E7A03E8B92577c15
Finished YearnRETHWstETHVault deployment
6-2. Deploy Convex Rocket Pool ETH vault
**_ ConvexRocketPoolETHVaulttImpl _**

Network: localhost
tx: 0xdedb89df5191e96350597a0e40b5999b247fd24c15781b1dfb0dfa66a044d0b0
contract address: 0x019F12a7DAa44A34CD0FF35055b0e2D4679D8521
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 3326327

---

internal token: 0xA22B79730CBEA3426CA0AA9597Cbe053460667E3
**_ RETHWstETHLPOracle _**

Network: localhost
tx: 0x5f5f21890361b90ec20b15ee21b68635b3735609f7ac13c87ae410cd27285582
contract address: 0xbc1B7f0e9C764deedA0cC56Ad10e5855f3140227
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 274947

---

993965357707900958
863793226351563
8889405820863320
ConvexRocketPoolETHVault.address 0x830647b95f38Af9e5811B4f140a9053b93322f08
Finished ConvexRocketPoolETHVault deployment
6-3. Deploy Convex FRAX 3CRV vault
**_ ConvexFRAX3CRVVaultImpl _**

Network: localhost
tx: 0x136dffbc88694ecc5350fe08d4f4e3c7760bfc5741c0e4efc1e538ca8eda94f1
contract address: 0x4eD6178D5dEf6AFD8e23334038609125cBB15C8F
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 3326327

---

internal token: 0xA0ecbe4a0e87b1559C962bb6E1F46286D41394Bf
**_ FRAX3CRVOracle _**

Network: localhost
tx: 0xd68fafb95358dd7f9e4359bd2e548bda04074997d8a026d7647f64101d7e3b6c
contract address: 0x48e9d06106F9B65963472965245F4c676fBD72d6
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 379655

---

414295634204344
863793226351563
8889405820863320
ConvexFRAX3CRVVault.address 0xb2E308Ef09697ed2b2d740c769CD3b0246DD1e6c
Finished ConvexFRAX3CRVVault deployment
6-4. Deploy Convex STETH vault
**_ ConvexSTETHVaultImpl _**

Network: localhost
tx: 0xcc2e5c6e68c57311133d346603bead34ce2a3f579ab0c517ec1460d4f78093d0
contract address: 0x9285cf8b9FFC4EADD054441F0A8E408deAd63CE0
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 3326327

---

internal token: 0xE72aAEEFA3821594c1D7fe2aB81361F0eC9e6e3e
**_ STECRVOracle _**

Network: localhost
tx: 0x82ed6ae20b480ec77886dfdd92d2247aa86774070015e21e480cdd65a274d075
contract address: 0x97d0cAb15bAaC862aA32679562e02200D2ABE0fA
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 209318

---

1031772634362418371
863793226351563
8889405820863320
ConvexSTETHVault.address 0xfDEba3d5Fd0819864FD652f5d6b0beC7a3DE5BF8
Finished ConvexSTETHVault deployment
6-5. Deploy Convex DOLA 3CRV vault
**_ ConvexDOLA3CRVVaultImpl _**

Network: localhost
tx: 0x6a253341eeaf80461e91737ee4bac0b345915a3ef55870817636696087f3c2f9
contract address: 0xb1257Dfc8977d747E38EB2032FF3813f734C70Be
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 3326327

---

internal token: 0x6DFC56b52a2B7F32A3d4348A53cF71a43C0Ed3a7
**_ DOLA3CRVOracle _**

Network: localhost
tx: 0xb00b834fffe18bea84b4b8c152a9de879c2d17c4aec45b8ccd011aa62d83d682
contract address: 0x5cc5bb306E1Be68Fbbfa6a34E0f314bC966A7080
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 463994

---

415662359913645
863793226351563
8889405820863320
ConvexDOLA3CRVVault.address 0xF44275a19A24D016364ddD9541FC9B17735De2f2
Finished ConvexDOLA3CRVVault deployment 8. Initialize lending pool
**_ StableDebtToken _**

Network: localhost
tx: 0x4028a040f2f8b993f69eb5d8e2eefa1c5c9868557cd14635e9b3cc58cf0bf46b
contract address: 0x96Cf503CeBF5CFf0ac30dFe93Aea2A21AA8dDA92
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 1716647

---

**_ VariableDebtToken _**

Network: localhost
tx: 0xfda274fe40715e2c241ba2c85f9aee361de0aaf601f5a181acd9594a52b35d1e
contract address: 0x15D7AdC7d6283d57D45017512567985e3A768B83
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 1421292

---

Duplicate definition of RewardsClaimed (RewardsClaimed(address,address,uint256), RewardsClaimed(address,address,address,uint256))
**_ AToken _**

Network: localhost
tx: 0xc122ea9803fb0444a13d02ae782136e43f0bf1b546144108f70c7c4c12ca3067
contract address: 0xf121De9FE385D7b62d2C8cE8954788A674cAAA8B
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 2325625

---

**_ ATokenForCollateral _**

Network: localhost
tx: 0x862b1fb32ed09484800bf7a65aff1a6a3d0afb7e61acbe153cc25da66d3d5d6f
contract address: 0x0Bd2306770D13a0BD11222A401753b62c04cA97F
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 2339950

---

**_ DefaultReserveInterestRateStrategy _**

Network: localhost
tx: 0x3ad574a82a203a92d032eaccb694e1c9f0d7ec24d1bb6bef42078afefcaab018
contract address: 0xecBC2AA619f8fFC19826E90c2b1d6FDEA4AeDD24
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 864461

---

Strategy address for asset DAI: 0xecBC2AA619f8fFC19826E90c2b1d6FDEA4AeDD24
**_ DefaultReserveInterestRateStrategy _**

Network: localhost
tx: 0x1473fd4b64e220eedeb8559e4704ca319d85c6e873d6b40617aed7527ffb045b
contract address: 0xeA86dE2e0C586456975319003Fc8C4AA9c7EE011
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 864461

---

Strategy address for asset USDC: 0xeA86dE2e0C586456975319003Fc8C4AA9c7EE011
**_ DefaultReserveInterestRateStrategy _**

Network: localhost
tx: 0xab167d36c39ea4f3ca51c50a78257bf598e6259e5c3de7fb3d8ede54aac83200
contract address: 0xD32AD632461AB79669036Aa8448F35de5185f081
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 864461

---

Strategy address for asset stETH: 0xD32AD632461AB79669036Aa8448F35de5185f081
**_ DefaultReserveInterestRateStrategy _**

Network: localhost
tx: 0xf776b29249b39dc85670083cf28a9213172b0d31731e1d6cb79ce2df35bf3925
contract address: 0xb6bAE75302f73398BE4F027837549d1382832B54
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 864461

---

Strategy address for asset yvRETH_WSTETH: 0xb6bAE75302f73398BE4F027837549d1382832B54
**_ DefaultReserveInterestRateStrategy _**

Network: localhost
tx: 0x760d5ea73c3c400be94db21a1776c65f5e99e3508e809e1e00604625eaf38ac5
contract address: 0xd830a07C49a6F3eBe7C193D7a3B637DDC4f3f26A
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 864461

---

Strategy address for asset cvxRETH_WSTETH: 0xd830a07C49a6F3eBe7C193D7a3B637DDC4f3f26A
**_ DefaultReserveInterestRateStrategy _**

Network: localhost
tx: 0xfd44740970c15c2c1e1f5fcb2f4cec434f95199d6d27a64de908951aefa9f655
contract address: 0x4B66C91dC1e632880ecC35FCc1e1ad957a7ed25f
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 864461

---

Strategy address for asset cvxFRAX_3CRV: 0x4B66C91dC1e632880ecC35FCc1e1ad957a7ed25f
**_ DefaultReserveInterestRateStrategy _**

Network: localhost
tx: 0x292d1105537edd53d1b3d216dccf227313f57b39a6ad3b0f83d75edc68260bdf
contract address: 0xaD3A2730BB6B88267785b1af2B702075537c4836
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 864461

---

Strategy address for asset cvxSTECRV: 0xaD3A2730BB6B88267785b1af2B702075537c4836
**_ DefaultReserveInterestRateStrategy _**

Network: localhost
tx: 0xc96cfadb84b83a8c2580aa874a04eb8463aec76838481a6990e0004681d98e5f
contract address: 0x82b828664197F9B42001b6dB4d4487A651f7Bf3e
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 864461

---

Strategy address for asset cvxDOLA_3CRV: 0x82b828664197F9B42001b6dB4d4487A651f7Bf3e

- Reserves initialization in 2 txs
  ----------chunkedSymbols--------------- [
  [ 'DAI', 'USDC', 'stETH', 'yvRETH_WSTETH' ],
  [ 'cvxRETH_WSTETH', 'cvxFRAX_3CRV', 'cvxSTECRV', 'cvxDOLA_3CRV' ]
  ]
  - Reserve ready for: DAI, USDC, stETH, yvRETH_WSTETH
    - gasUsed 8331326
  - Reserve ready for: cvxRETH_WSTETH, cvxFRAX_3CRV, cvxSTECRV, cvxDOLA_3CRV
    - gasUsed 8606754
  - Init for: DAI, USDC, stETH, yvRETH_WSTETH, cvxRETH_WSTETH, cvxFRAX_3CRV, cvxSTECRV, cvxDOLA_3CRV
    **_ LendingPoolCollateralManager _**

Network: localhost
tx: 0x71334126cfbfba36db672f8a22af13bf788548ea9aa4eea6b8f7e2ea3eda88fd
contract address: 0xe7E1994Ef5A6D8c88e4B8e27E63A1B78db1072A4
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 2919039

---

        Setting lending pool collateral manager implementation with address 0xe7E1994Ef5A6D8c88e4B8e27E63A1B78db1072A4
        Setting SturdyProtocolDataProvider at AddressesProvider at id: 0x01 0xe7E1994Ef5A6D8c88e4B8e27E63A1B78db1072A4

**_ WalletBalanceProvider _**

Network: localhost
tx: 0x21e80541873517137ebdc0202275b2840a26df8f56fc2594d62a5acf5f55384f
contract address: 0x616a916Af314884c4dAEfcA6AA3c98a561278f01
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 629852

---

**_ UiPoolDataProvider _**

Network: localhost
tx: 0xb3c59efa8089c61f2c4cd884e9464a900297221939815069c7e846b8d6b3a27a
contract address: 0x591d0398952f25291957d9bA30ac0009870acC33
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 3342751

---

UiPoolDataProvider deployed at: 0x591d0398952f25291957d9bA30ac0009870acC33
**_ UiIncentiveDataProvider _**

Network: localhost
tx: 0xcc1723fce3b87a85453d9d44cf1a43062017596ed994fc300251570c2acaab05
contract address: 0x1eD95f15B4f8d1653471eA3a2015cF41DaDf4c5c
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 1854518

---

UiIncentiveDataProvider deployed at: 0x1eD95f15B4f8d1653471eA3a2015cF41DaDf4c5c
8-1. Deploy Collateral Adapter
**_ CollateralAdapterImpl _**

Network: localhost
tx: 0x36b60c5d6fd8e01a3ae5a0a1099c27c901b06ed6cfdd2c8d720da4626b777f58
contract address: 0x0e3167B147dCf65456A071967b5e3a265C4A0003
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 296537

---

CollateralAdapter.address 0x89D02f895778F6a0eDb620a162B0018847EAe8f6
Finished CollateralAdapter deployment
8-2. Deploy Liquidator
**_ LiquidatorImpl _**

Network: localhost
tx: 0x84a774c70a9fb7e9211e7cc5291bf4b9d7133ab3f7a7ed4f85663fd967e5412a
contract address: 0x8196263D97DE9A1198Da2A1830b5A49cBe6eb3FE
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 1094735

---

Liquidator.address 0x8196263D97DE9A1198Da2A1830b5A49cBe6eb3FE
Finished Liquidator deployment
8-3. Deploy Vault Helper
**_ DeployVaultHelper _**

Network: localhost
tx: 0xbd5e0e8280c706648b8e11ac8b09b63929b227ed7e21577e603b0555f55772c5
contract address: 0x2B6953Ba77DcDC967A2Ac2e8d3d8dc34E015a996
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 1271691

---

DeployVaultHelper.address 0x2B6953Ba77DcDC967A2Ac2e8d3d8dc34E015a996
Finished DeployVaultHelper deployment
8-4. Deploy Yield Manager
**_ YieldManagerImpl _**

Network: localhost
tx: 0x4b2ee7a1120e0617d584ca544101f5afba4b019ac454b1551a9dca50245241ba
contract address: 0x34884587E05075CAa21Ca51C11c6fe2F3e934514
deployer address: 0xb4124cEB3451635DAcedd11767f004d8a28c6eE7
gas price: 8000000000
gas used: 1365880

---

YieldManager.address 0x8c30CE2bCE4523681DA9644cA63e1E3f5f41c3d6
Finished YieldManager deployment

Finished migrations
Contracts deployed at localhost

---

N# Contracts: 66
LendingPoolAddressesProvider: 0x3a5e7db2E0EA9e69fB53Cd8582e64D4001746E8c
LendingPoolAddressesProviderRegistry: 0xda87577f9eb8B15B26C00619FD06d4485880310D
ReserveLogic: 0xA6f48C8190be8F92A4c31aAE4756289Ef3d91477
GenericLogic: 0xa51d9BD713E0a812e5289D926F8f721eb1d71112
ValidationLogic: 0x5aE47822Da849508020c25E2E92c4a4cC4E03001
LendingPoolImpl: 0x677B89Ac909215B7e6B6bA46e229eBCe08d25e79
LendingPool: 0x2A4d822BFB34d377c978F28a6C332Caa2fF87530
LendingPoolConfiguratorImpl: 0xa222efa1133c6702a83eFD04bD5E7Ef941EDb2EC
LendingPoolConfigurator: 0x35D6445E0D43fdDc23ac4cdb6222cDEdF5E715eE
StableAndVariableTokensHelper: 0x3990b44d6233D8287c62635028FAc7b046c5607A
ATokensAndRatesHelper: 0x58a749D6760e7dd926dF737Ec45b65F687aBbE52
SturdyOracle: 0x2e9f55f7266d8C7e07d359daBA0e743e331B7A1A
LendingRateOracle: 0x609D79AD1935BB9aEce827B8eC111e87122928a7
SturdyProtocolDataProvider: 0x48c2Eac33521070509f9819A824a3D5686Ba5ce8
StakedTokenIncentivesControllerImpl: 0x16cC86D9c42208eE9e22b377e3d7927630733a06
StakedTokenIncentivesController: 0xA897716BA0c7603B10b8b2854c104912a6058542
SturdyTokenImpl: 0x0f407B6532BB4092638Ad5CEd2b17BD34d521402
SturdyToken: 0x7Ff897A14796072a1d23e0002f3Dca9Bc80af677
UniswapAdapter: 0x9310dC480CbF907D6A3c41eF2e33B09E61605531
CurveswapAdapter: 0xBf61048590B6FAd46Fb446aA241fA33f7a22851b
LidoVaultImpl: 0x9310dC480CbF907D6A3c41eF2e33B09E61605531
LidoVault: 0x1A4313DdE95487EAAbfF58A181fd34cbe3638041
YearnRETHWstETHVaultImpl: 0x5f4e510503d83bd1a5436bDaE2923489dA0Be454
YearnRETHWstETHVault: 0x8d58c3574A6D32F5F848Abe8E7A03E8B92577c15
RETHWstETHLPOracle: 0xbc1B7f0e9C764deedA0cC56Ad10e5855f3140227
ConvexRocketPoolETHVaulttImpl: 0x019F12a7DAa44A34CD0FF35055b0e2D4679D8521
ConvexRocketPoolETHVault: 0x830647b95f38Af9e5811B4f140a9053b93322f08
ConvexFRAX3CRVVaultImpl: 0x4eD6178D5dEf6AFD8e23334038609125cBB15C8F
ConvexFRAX3CRVVault: 0xb2E308Ef09697ed2b2d740c769CD3b0246DD1e6c
FRAX3CRVOracle: 0x48e9d06106F9B65963472965245F4c676fBD72d6
ConvexSTETHVaultImpl: 0x9285cf8b9FFC4EADD054441F0A8E408deAd63CE0
ConvexSTETHVault: 0xfDEba3d5Fd0819864FD652f5d6b0beC7a3DE5BF8
STECRVOracle: 0x97d0cAb15bAaC862aA32679562e02200D2ABE0fA
ConvexDOLA3CRVVaultImpl: 0xb1257Dfc8977d747E38EB2032FF3813f734C70Be
ConvexDOLA3CRVVault: 0xF44275a19A24D016364ddD9541FC9B17735De2f2
DOLA3CRVOracle: 0x5cc5bb306E1Be68Fbbfa6a34E0f314bC966A7080
StableDebtToken: 0x96Cf503CeBF5CFf0ac30dFe93Aea2A21AA8dDA92
VariableDebtToken: 0x15D7AdC7d6283d57D45017512567985e3A768B83
AToken: 0xf121De9FE385D7b62d2C8cE8954788A674cAAA8B
aTokenImpl: 0xf121De9FE385D7b62d2C8cE8954788A674cAAA8B
ATokenForCollateral: 0x0Bd2306770D13a0BD11222A401753b62c04cA97F
aTokenForCollateralImpl: 0x0Bd2306770D13a0BD11222A401753b62c04cA97F
DefaultReserveInterestRateStrategy: 0x82b828664197F9B42001b6dB4d4487A651f7Bf3e
rateStrategyStableTwo: 0xecBC2AA619f8fFC19826E90c2b1d6FDEA4AeDD24
rateStrategyStableThree: 0xeA86dE2e0C586456975319003Fc8C4AA9c7EE011
rateStrategySTETH: 0xD32AD632461AB79669036Aa8448F35de5185f081
rateStrategyYVRETH_WSTETH: 0xb6bAE75302f73398BE4F027837549d1382832B54
rateStrategyCVXRETH_WSTETH: 0xd830a07C49a6F3eBe7C193D7a3B637DDC4f3f26A
rateStrategyCVXFRAX_3CRV: 0x4B66C91dC1e632880ecC35FCc1e1ad957a7ed25f
rateStrategyCVXSTECRV: 0xaD3A2730BB6B88267785b1af2B702075537c4836
rateStrategyCVXDOLA_3CRV: 0x82b828664197F9B42001b6dB4d4487A651f7Bf3e
LendingPoolCollateralManagerImpl: 0xe7E1994Ef5A6D8c88e4B8e27E63A1B78db1072A4
LendingPoolCollateralManager: 0xe7E1994Ef5A6D8c88e4B8e27E63A1B78db1072A4
WalletBalanceProvider: 0x616a916Af314884c4dAEfcA6AA3c98a561278f01
UiPoolDataProvider: 0x591d0398952f25291957d9bA30ac0009870acC33
UiIncentiveDataProvider: 0x1eD95f15B4f8d1653471eA3a2015cF41DaDf4c5c
CollateralAdapterImpl: 0x0e3167B147dCf65456A071967b5e3a265C4A0003
CollateralAdapter: 0x89D02f895778F6a0eDb620a162B0018847EAe8f6
LiquidatorImpl: 0x8196263D97DE9A1198Da2A1830b5A49cBe6eb3FE
Liquidator: 0x8196263D97DE9A1198Da2A1830b5A49cBe6eb3FE
DeployVaultHelper: 0x2B6953Ba77DcDC967A2Ac2e8d3d8dc34E015a996
YieldManagerImpl: 0x34884587E05075CAa21Ca51C11c6fe2F3e934514
YieldManager: 0x8c30CE2bCE4523681DA9644cA63e1E3f5f41c3d6
MockAToken: 0x880bf628817254CD701062426Dd068AB1a556e7F
MockStableDebtToken: 0xb5a35165047fed7440D3a75909c0949bf1943696
MockVariableDebtToken: 0x41e657cAdE74f45b7E2F0F4a5AeE0239f2fB4E1F

✨ Done in 77.24s.
syedgulzarali@Syeds-MacBook-Pro code4rena-may-2022 %
