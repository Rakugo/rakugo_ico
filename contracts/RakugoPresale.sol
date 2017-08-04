pragma solidity ^0.4.13;

import 'zeppelin-solidity/contracts/crowdsale/Crowdsale.sol';
import 'zeppelin-solidity/contracts/crowdsale/CappedCrowdsale.sol';

contract RakugoPresale is CappedCrowdsale {

  mapping(address => uint) private balances;

  function RakugoPresale(uint256 _startBlock, uint256 _endBlock, uint256 _rate, address _wallet)
  CappedCrowdsale(5000 ether)
  Crowdsale(_startBlock, _endBlock, _rate, _wallet){
  }

  function buyTokens(address beneficiary) payable {
    require(beneficiary != 0x0);
    require(validPurchase());

    uint256 weiAmount = msg.value;

    // calculate token amount to be created
    uint256 tokens = weiAmount.mul(rate);

    // update state
    weiRaised = weiRaised.add(weiAmount);

    // add balance
    balances[msg.sender] = balances[msg.sender].add(tokens);

    // notarize tx
    TokenPurchase(msg.sender, beneficiary, weiAmount, tokens);

    forwardFunds();
  }

  function balanceOf(address _owner) constant returns (uint256 balance) {
    return balances[_owner];
  }
}
