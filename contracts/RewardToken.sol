// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract RewardToken is ERC20, Ownable {
    constructor() ERC20("RewardToken", "RTK") {
        _mint(msg.sender, 1000000 * 10 ** decimals()); // Mint initial supply to the owner
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }
} 