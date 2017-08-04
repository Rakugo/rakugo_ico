pragma solidity ^0.4.13;

import "zeppelin-solidity/contracts/token/StandardToken.sol";
import "zeppelin-solidity/contracts/token/LimitedTransferToken.sol";

contract RakugoToken is StandardToken, LimitedTransferToken {
    event Create(address indexed to, uint256 amount);
    event Burn(address indexed burner, uint indexed value);

    string public constant symbol = "RKT";
    string public constant name = "Rakugo Seed Token";
    uint8 public constant decimals = 18;

    function create(address _buyer, uint256 _amount) returns (bool) {
        totalSupply = totalSupply.add(_amount);
        balances[_buyer] = balances[_buyer].add(_amount);
        Create(_buyer, _amount);
        return true;
    }

    function burn(uint _value) public {
        require(_value > 0);
        require(_value >= balanceOf(burner));

        address burner = msg.sender;
        balances[burner] = balances[burner].sub(_value);
        totalSupply = totalSupply.sub(_value);
        Burn(burner, _value);
    }
}
