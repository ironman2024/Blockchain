// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.7.0;

contract banking {
    mapping(address => uint) public userAccount;
    mapping(address => bool) public userExists;

    // 1️⃣ Create Account
    function createAcc() public payable returns(string memory) {
        require(userExists[msg.sender] == false, "Account already created");
        if (msg.value == 0) {
            userAccount[msg.sender] = 0;
            userExists[msg.sender] = true;
            return "Account created successfully with 0 balance";
        }
        userAccount[msg.sender] = msg.value;
        userExists[msg.sender] = true;
        return "Account created successfully with initial deposit";
    }

    // 2️⃣ Deposit Amount
    function deposit() public payable returns(string memory) {
        require(userExists[msg.sender] == true, "Account not created");
        require(msg.value > 0, "Deposit value must be greater than 0");
        userAccount[msg.sender] += msg.value;
        return "Deposit successful";
    }

    // 3️⃣ Withdraw Amount
    function withdraw(uint amount) public payable returns(string memory) {
        require(userExists[msg.sender] == true, "Account not created");
        require(userAccount[msg.sender] >= amount, "Insufficient balance");
        require(amount > 0, "Enter a non-zero value");
        userAccount[msg.sender] -= amount;
        msg.sender.transfer(amount);
        return "Withdrawal successful";
    }

    // 4️⃣ Transfer Amount (between accounts)
    function TransferAmount(address payable userAddress, uint amount) public returns(string memory) {
        require(userExists[msg.sender] == true, "Sender account not created");
        require(userExists[userAddress] == true, "Receiver account not created");
        require(userAccount[msg.sender] >= amount, "Insufficient balance");
        require(amount > 0, "Enter a non-zero amount");
        userAccount[msg.sender] -= amount;
        userAccount[userAddress] += amount;
        return "Transfer successful";
    }

    // 5️⃣ Show Balance
    function showBalance() public view returns(uint) {
        require(userExists[msg.sender] == true, "Account not created");
        return userAccount[msg.sender];
    }
}
