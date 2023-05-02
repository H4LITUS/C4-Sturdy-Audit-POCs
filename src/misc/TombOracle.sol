// SPDX-License-Identifier: AGPL-3.0-only
// Using the same Copyleft License as in the original Repository
pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import { Ownable } from "../dependencies/openzeppelin/contracts/Ownable.sol";
import "./interfaces/IOracle.sol";
import "../interfaces/IChainlinkAggregator.sol";
import "../protocol/libraries/math/BoringMath.sol";
import "../dependencies/openzeppelin/contracts/IERC20.sol";
import "../interfaces/IUniswapV2Pair.sol";
import "../lib/FixedPoint.sol";

contract TombOracle is IOracle, Ownable {
    using FixedPoint for *;
    using BoringMath for uint256;

    uint256 public constant PERIOD = 10 minutes;
    IChainlinkAggregator public constant FTM_USD =
        IChainlinkAggregator(0xf4766552D15AE4d256Ad41B6cf2933482B0680dc);
    IUniswapV2Pair public constant TOMB_FTM =
        IUniswapV2Pair(0x2A651563C9d3Af67aE0388a5c8F89b867038089e);
    bool isCumulativePrice;

    struct PairInfo {
        uint256 priceCumulativeLast;
        uint256 priceAverage;
        uint32 blockTimestampLast;
    }

    PairInfo public pairInfo;

    function _get(uint32 blockTimestamp) internal view returns (uint256) {
        uint256 priceCumulative = TOMB_FTM.price1CumulativeLast();

        // if time has elapsed since the last update on the pair, mock the accumulated price values
        (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast) =
            IUniswapV2Pair(TOMB_FTM).getReserves();
        priceCumulative += uint256(FixedPoint.fraction(reserve0, reserve1)._x)
            * (blockTimestamp - blockTimestampLast); // overflows ok

        // overflow is desired, casting never truncates
        // cumulative price is in (uq112x112 price * seconds) units so we simply wrap it after
        // division by time elapsed
        return priceCumulative;
    }

    // Get the latest exchange rate, if no valid (recent) rate is available, return false
    /// @inheritdoc IOracle
    function get() public override returns (bool, uint256) {
        uint32 blockTimestamp = uint32(block.timestamp);
        if (pairInfo.blockTimestampLast == 0) {
            pairInfo.blockTimestampLast = blockTimestamp;
            pairInfo.priceCumulativeLast = _get(blockTimestamp);
            return (false, 0);
        }
        uint32 timeElapsed = blockTimestamp - pairInfo.blockTimestampLast; // overflow is desired

        if (timeElapsed < PERIOD) {
            return (true, pairInfo.priceAverage);
        }

        uint256 priceCumulative = _get(blockTimestamp);
        pairInfo.priceAverage = uint256(
            FixedPoint.uq112x112(
                uint224((priceCumulative - pairInfo.priceCumulativeLast) / timeElapsed)
            ).mul(1e18).decode144()
        ).mul(uint256(FTM_USD.latestAnswer())) / 1e18;

        pairInfo.blockTimestampLast = blockTimestamp;
        pairInfo.priceCumulativeLast = priceCumulative;

        return (true, pairInfo.priceAverage);
    }

    // Check the last exchange rate without any state changes
    /// @inheritdoc IOracle
    function peek() public view override returns (bool, int256) {
        uint32 blockTimestamp = uint32(block.timestamp);
        if (pairInfo.blockTimestampLast == 0) {
            return (false, 0);
        }
        uint32 timeElapsed = blockTimestamp - pairInfo.blockTimestampLast; // overflow is desired
        if (timeElapsed < PERIOD) {
            return (true, int256(pairInfo.priceAverage));
        }

        uint256 priceCumulative = _get(blockTimestamp);
        int256 priceAverage = int256(
            uint256(
                FixedPoint.uq112x112(
                    uint224((priceCumulative - pairInfo.priceCumulativeLast) / timeElapsed)
                ).mul(1e18).decode144()
            ).mul(uint256(FTM_USD.latestAnswer())) / 1e18
        );

        return (true, priceAverage);
    }

    function enableCumulativePrice(bool enable) external onlyOwner {
        isCumulativePrice = enable;
        if (enable) {
            get();
        }
    }

    // Check the current spot exchange rate without any state changes
    /// @inheritdoc IOracle
    function latestAnswer() external view override returns (int256 rate) {
        (uint256 reserve0, uint256 reserve1,) = TOMB_FTM.getReserves();
        if (isCumulativePrice) {
            (, rate) = peek();
        }

        if (rate <= 0) {
            rate =
                int256((reserve0.mul(1e18) / reserve1).mul(uint256(FTM_USD.latestAnswer())) / 1e18);
        }
    }
}
