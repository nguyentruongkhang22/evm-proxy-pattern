// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.9;
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "./interfaces/ICount.sol";

contract Count is Initializable, ICount, OwnableUpgradeable {
  uint256 private _count;

  constructor() {
    _disableInitializers();
  }

  function initialize() external override initializer {
    _count = 0;
  }

  function currentCount() public view returns (uint256) {
    return _count;
  }

  function increment() public {
    _count += 1;
  }

  function decrement() public {
    _count -= 1;
  }
}
