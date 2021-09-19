// SPDX-License-Identifier: Unlicensed
pragma solidity >=0.8.4;
pragma experimental ABIEncoderV2;

import "../mixins/LevelBook.sol";

contract TestLevelBook is LevelBook {
    using TickMath for uint160;

    int256 public liqDelta;
    uint256 public odometer;

    function getLevelState (uint8 poolIdx, int24 tick) public view returns
        (BookLevel memory) {
        return levelState(poolIdx, tick);
    }

    function pullFeeOdometer (uint8 poolIdx, int24 mid, int24 bid, int24 ask,
                              uint256 feeGlobal)
        public view returns (uint256) {
        return clockFeeOdometer(poolIdx, mid, bid, ask, feeGlobal);
    }

    function testCrossLevel (uint8 poolIdx, int24 tick, bool isBuy,
                             uint256 feeGlobal) public {
        liqDelta = crossLevel(poolIdx, tick, isBuy, feeGlobal);
    }

    function testAdd (uint8 poolIdx, int24 midTick, int24 bidTick, int24 askTick,
                      uint128 liq, uint256 globalFee) public {
        odometer = addBookLiq(poolIdx, midTick, bidTick, askTick, liq, globalFee);
    }

    function testRemove (uint8 poolIdx, int24 midTick, int24 bidTick, int24 askTick,
                         uint128 liq, uint256 globalFee) public {
        odometer = removeBookLiq(poolIdx, midTick, bidTick, askTick, liq, globalFee);
    }

    function testSetTickSize (uint8 poolIdx, uint16 tickSize) public {
        setTickSize(poolIdx, tickSize);
    }

    function testGetTickSize (uint8 poolIdx) public view returns (uint16) {
        return getTickSize(poolIdx);
    }

    function hasTickBump (uint8 poolIdx, int24 tick) public view returns (bool) {
        return hasTick(poolIdx, tick);
    }

}
