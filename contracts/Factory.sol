// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/proxy/Clones.sol";
import "contracts/interfaces/ICount.sol";
import "contracts/Count.sol";

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract Factory {
  mapping(bytes32 => address) private _implements;
  uint256 private _implementCount;

  constructor() {
    _setImplement((keccak256("Hello")), address(new Count()));
  }

  function setImplement(bytes32 key, address implement) public {
    _setImplement(key, implement);
  }

  function _setImplement(bytes32 key, address implement) internal {
    _implements[key] = implement;
  }

  function _cloneImplement(bytes32 key) internal returns (address) {
    address implement = _implements[key];
    require(implement != address(0), "Factory: implement not found");
    address newImplement = Clones.cloneDeterministic(implement, bytes32(_implementCount));

    return newImplement;
  }

  function getImplement(bytes32 key) public view returns (address) {
    return _implements[key];
  }

  function getImplementCount() public view returns (uint256) {
    return _implementCount;
  }

  function createNewProxy(bytes32 key) public returns (address) {
    address newImplement = _cloneImplement(key);
    ICount(newImplement).initialize();

    _implementCount += 1;

    return newImplement;
  }

  function getProxyAddress(uint256 index, bytes32 key) public view returns (address) {
    address implement = _implements[key];
    require(implement != address(0), "Factory: implement not found");
    address proxyAddress = Clones.predictDeterministicAddress(implement, bytes32(index), address(this));
    return proxyAddress;
  }
}
