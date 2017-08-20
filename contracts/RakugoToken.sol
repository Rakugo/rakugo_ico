pragma solidity ^0.4.13;

import "zeppelin-solidity/contracts/token/LimitedTransferToken.sol";
import "zeppelin-solidity/contracts/token/MintableToken.sol";

contract RakugoToken is MintableToken, LimitedTransferToken {

    event Burn(address indexed burner, uint indexed value);

    string public constant symbol = "RKT";
    string public constant name = "Rakugo Seed Token";
    uint8 public constant decimals = 18;

    function transferableTokens(address holder, uint64 time) constant public returns (uint256) {
        require(mintingFinished);
        return balanceOf(holder);
    }

    function burn(uint _value) canTransfer(msg.sender, _value) public {
        require(_value > 0);
        require(_value >= balanceOf(burner));

        address burner = msg.sender;
        balances[burner] = balances[burner].sub(_value);
        totalSupply = totalSupply.sub(_value);
        Burn(burner, _value);
    }
}
