// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.9;

contract CountNew {
  uint256 private _count;

  constructor() {}

  function currentCount() public view returns (uint256) {
    return _count;
  }

  function increment() public {
    _count += 1;
  }

  function decrement() public {
    _count -= 1;
  }

  function decrementByTwo() public {
    _count -= 2;
  }

  function incrementByTwo() public {
    _count += 2;
  }
}
