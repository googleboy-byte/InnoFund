// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./RewardToken.sol";

contract FundingContract {
    struct Project {
        address payable creator;
        uint256 goalAmount;
        uint256 fundsRaised;
        bool isFunded;
    }

    mapping(uint256 => Project) public projects;
    uint256 public projectCount;

    address payable public owner; // Address to receive the fee
    uint256 public feePercentage = 275; // 2.75% fee (in basis points)
    RewardToken public rewardToken; // Reference to the reward token contract

    event ProjectFunded(uint256 projectId, address funder, uint256 amount);

    constructor(address _rewardTokenAddress) {
        owner = payable(msg.sender); // Set the contract deployer as the owner
        rewardToken = RewardToken(_rewardTokenAddress); // Initialize the reward token contract
    }

    function createProject(uint256 _goalAmount) public {
        projectCount++;
        projects[projectCount] = Project(payable(msg.sender), _goalAmount, 0, false);
    }

    function fundProject(uint256 _projectId) public payable {
        Project storage project = projects[_projectId];
        require(msg.value > 0, "Must send ETH to fund the project");
        require(!project.isFunded, "Project is already fully funded");

        uint256 fee = (msg.value * feePercentage) / 10000; // Calculate the fee
        uint256 amountAfterFee = msg.value - fee; // Amount after deducting the fee

        // Transfer the fee to the owner
        owner.transfer(fee);
        
        project.fundsRaised += amountAfterFee;
        if (project.fundsRaised >= project.goalAmount) {
            project.isFunded = true;
        }

        // Reward the funder with tokens
        uint256 rewardAmount = (amountAfterFee * 10) / 100; // 10% of the funded amount as reward
        rewardToken.mint(msg.sender, rewardAmount); // Mint tokens to the funder

        emit ProjectFunded(_projectId, msg.sender, amountAfterFee);
    }

    function withdrawFunds(uint256 _projectId) public {
        Project storage project = projects[_projectId];
        require(msg.sender == project.creator, "Only the creator can withdraw funds");
        require(project.isFunded, "Project is not fully funded");

        uint256 amount = project.fundsRaised;
        project.fundsRaised = 0; // Prevent re-entrancy
        project.creator.transfer(amount);
    }
} 