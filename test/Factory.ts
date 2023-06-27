import { time, loadFixture } from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { expect } from "chai";
import { ethers } from "hardhat";
import hardhat from "hardhat";

import { Count, Count__factory } from "../typechain-types";
import { CountInterface } from "../typechain-types/contracts/Count";

describe("Lock", function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  let proxy: Count;
  async function fixture() {
    const [admin, user] = await ethers.getSigners();

    const Factory = await ethers.getContractFactory("Factory");

    const factory = await Factory.deploy();

    await factory.waitForDeployment();

    return { admin, user, factory };
  }
  describe("Create new implementation", function () {
    it("Should create new implementation", async function () {
      const { factory, admin, user } = await loadFixture(fixture);
      // await factory.setImplement(Buffer.from("count1"), await count.getAddress());

      await factory.createNewProxy("0x06b3dfaec148fb1bb2b066f10ec285e7c9bf402ab32aa78a5d38e34566810cd2");
      const proxyAddress = await factory.getProxyAddress(1, "0x06b3dfaec148fb1bb2b066f10ec285e7c9bf402ab32aa78a5d38e34566810cd2");
      console.log("📢[Factory.ts:29]: proxyAddress: ", proxyAddress);

      const Count: Count__factory = await ethers.getContractFactory("Count");

      const hehe: CountInterface = Count.attach(proxyAddress);
      const hehe = await proxy.currentCount();
      console.log("📢[Factory.ts:36]: hehe: ", hehe);
    });
  });
});
