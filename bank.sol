// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract Banking {
    mapping(address => uint256) public userAccount;
    mapping(address => bool) public userExists;

    // 1️⃣ Create Account
    function createAcc() external payable returns (string memory) {
        require(!userExists[msg.sender], "Account already exists");

        userExists[msg.sender] = true;
        userAccount[msg.sender] = msg.value;

        if (msg.value == 0) {
            return "Account created successfully with 0 balance";
        } else {
            return "Account created successfully with initial deposit";
        }
    }

    // 2️⃣ Deposit Amount
    function deposit() external payable returns (string memory) {
        require(userExists[msg.sender], "Account not created");
        require(msg.value > 0, "Deposit value must be greater than 0");

        userAccount[msg.sender] += msg.value;
        return "Deposit successful";
    }

    // 3️⃣ Withdraw Amount
    function withdraw(uint256 amount) external returns (string memory) {
        require(userExists[msg.sender], "Account not created");
        require(amount > 0, "Enter a non-zero amount");
        require(userAccount[msg.sender] >= amount, "Insufficient balance");

        userAccount[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);

        return "Withdrawal successful";
    }

    // 4️⃣ Transfer Amount (between accounts)
    function transferAmount(address userAddress, uint256 amount) external returns (string memory) {
        require(userExists[msg.sender], "Sender account not created");
        require(userExists[userAddress], "Receiver account not created");
        require(amount > 0, "Enter a non-zero amount");
        require(userAccount[msg.sender] >= amount, "Insufficient balance");

        userAccount[msg.sender] -= amount;
        userAccount[userAddress] += amount;

        return "Transfer successful";
    }

    // 5️⃣ Show Balance
    function showBalance() external view returns (uint256) {
        require(userExists[msg.sender], "Account not created");
        return userAccount[msg.sender];
    }
}
