// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.9;

import "hardhat/console.sol";

interface ICount {
  function initialize() external;

  function currentCount() external view returns (uint256);

  function increment() external;

  function decrement() external;
}
