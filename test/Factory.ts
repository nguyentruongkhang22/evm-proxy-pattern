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
      await factory.createNewProxy();
      const count = await ethers.getContractAt("Count", await factory.getProxyAddress(0));

      const currentCount = await count.currentCount();
      console.log(" -- currentCount: ", currentCount);

      await count.increment();
      const newCount = await count.currentCount();
      console.log(" -- newCount: ", newCount);
    });
  });
});
