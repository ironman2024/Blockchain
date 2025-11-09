// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// TITLE: Create Student Data in Solidity Program using Constructs
// This contract demonstrates the use of Structures, Arrays, Constructor, and Fallback Function.

contract StudentData {

    // Structure to hold student details
    struct Student {
        int ID;
        string fName;
        string lName;
        int[2] marks;  // Fixed-size array to hold 2 subject marks
    }

    address public owner;     // Owner of the contract
    int public stdCount = 0;  // Student count

    // Mapping student count to Student record
    mapping(int => Student) public stdRecords;

    // Modifier to restrict functions to owner only
    modifier onlyOwner {
        require(owner == msg.sender, "Only owner can call this function");
        _;
    }

    // Constructor runs once at deployment
    constructor() {
        owner = msg.sender;
    }

    // Function to add new student records
    function addNewRecords(
        int _ID,
        string memory _fName,
        string memory _lName,
        int[2] memory _marks
    ) public onlyOwner {
        stdCount = stdCount + 1;
        stdRecords[stdCount] = Student(_ID, _fName, _lName, _marks);
    }

    // Fallback function to accept ether or invalid calls
    fallback() external payable { }

    // Receive function to accept plain Ether transfers
    receive() external payable { }

    // View contract balance (optional)
    function getContractBalance() public view returns(uint) {
        return address(this).balance;
    }
}
