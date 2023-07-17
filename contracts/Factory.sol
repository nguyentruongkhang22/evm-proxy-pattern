// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/proxy/Clones.sol";
import "contracts/interfaces/ICount.sol";
import "contracts/Count.sol";

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract Factory {
  address private _implement;
  uint256 private _implementCount;

  constructor() {
    _setImplement(address(new Count()));
  }

  function setImplement(address implement) public {
    _setImplement(implement);
  }

  function _setImplement(address implement) internal {
    _implement = implement;
  }

  function _cloneImplement() internal returns (address) {
    address implement = _implement;
    require(implement != address(0), "Factory: implement not found");
    address newImplement = Clones.cloneDeterministic(implement, bytes32(_implementCount));

    return newImplement;
  }

  function getImplement() public view returns (address) {
    return _implement;
  }

  function createNewProxy() public returns (address) {
    address newImplement = _cloneImplement();
    ICount(newImplement).initialize();

    _implementCount += 1;

    return newImplement;
  }

  function getProxyAddress(uint256 index) public view returns (address) {
    address implement = _implement;
    require(implement != address(0), "Factory: implement not found");
    address proxyAddress = Clones.predictDeterministicAddress(implement, bytes32(index), address(this));
    return proxyAddress;
  }
}
