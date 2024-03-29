// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import { ERC20 } from "../dependencies/openzeppelin/contracts/ERC20.sol";
import { VersionedInitializable } from
    "../protocol/libraries/sturdy-upgradeability/VersionedInitializable.sol";
import { ILendingPoolAddressesProvider } from "../interfaces/ILendingPoolAddressesProvider.sol";

/**
 * @notice implementation of the BRICK token contract
 * @author Sturdy
 */
contract SturdyToken is ERC20, VersionedInitializable {
    string internal constant NAME = "Sturdy Token";
    string internal constant SYMBOL = "BRICK";
    uint8 internal constant DECIMALS = 18;

    /// @dev the amount being distributed for supplier and borrower
    uint256 internal constant DISTRIBUTION_AMOUNT = 100_000_000 ether;

    uint256 public constant REVISION = 1;

    /// @dev owner => next valid nonce to submit with permit()
    mapping(address => uint256) public _nonces;

    constructor() public ERC20(NAME, SYMBOL) { }

    /**
     * @dev initializes the contract upon assignment to the InitializableAdminUpgradeabilityProxy
     * @param _provider the address of the provider
     */
    function initialize(ILendingPoolAddressesProvider _provider) external initializer {
        _setupDecimals(DECIMALS);
        _mint(_provider.getIncentiveController(), DISTRIBUTION_AMOUNT);
    }

    /**
     * @dev returns the revision of the implementation contract
     */
    function getRevision() internal pure override returns (uint256) {
        return REVISION;
    }
}
