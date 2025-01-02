const hre = require("hardhat");

async function main() {
    // Deploy RewardToken
    const RewardToken = await hre.ethers.getContractFactory("RewardToken");
    const rewardToken = await RewardToken.deploy();
    await rewardToken.deployed();
    console.log("RewardToken deployed to:", rewardToken.address);

    // Deploy FundingContract with the address of RewardToken
    const FundingContract = await hre.ethers.getContractFactory("FundingContract");
    const fundingContract = await FundingContract.deploy(rewardToken.address);
    await fundingContract.deployed();
    console.log("FundingContract deployed to:", fundingContract.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    }); 