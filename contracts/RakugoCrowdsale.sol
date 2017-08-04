pragma solidity ^0.4.13;

import './RakugoToken.sol';
import './RakugoPresale.sol';
import 'zeppelin-solidity/contracts/crowdsale/Crowdsale.sol';
import "zeppelin-solidity/contracts/crowdsale/CappedCrowdsale.sol";

contract RakugoCrowdsale is Crowdsale, CappedCrowdsale {

  RakugoToken public rakugoToken;
  address public rakugoPresaleAddress;
  uint256 public rate = 1200;
  uint256 public companyTokens = 16000000;

  function RakugoCrowdsale(
  uint256 _saleCap,
  uint256 _startBlock,
  uint256 _endBlock,
  address _wallet,
  address[] _presales,
  address _presaleAddress
  )
  CappedCrowdsale(_saleCap)
  Crowdsale(_startBlock, _endBlock, rate, _wallet) {
    rakugoToken = new RakugoToken();
    rakugoPresaleAddress = _presaleAddress;
    initializeCompanyTokens(companyTokens);
    presalePurchase(_presales, _presaleAddress);
  }

  function buyTokens(address beneficiary) payable {
    require(beneficiary != 0x0);
    require(validPurchase());

    uint256 weiAmount = msg.value;
    uint256 tokens = weiAmount.mul(rate);
    contribute(msg.sender, beneficiary, weiAmount, tokens);
    forwardFunds();
  }

  function initializeCompanyTokens(uint256 _companyTokens) internal {
    contribute(wallet, wallet, 0, _companyTokens);//no paid eth for company liquidity
  }

  function presalePurchase(address[] presales, address _presaleAddress) internal {
    RakugoPresale rakugoPresale = RakugoPresale(_presaleAddress);
    for (uint i = 0; i < presales.length; i++) {
        address presalePurchaseAddress = presales[i];
        uint256 contributionAmmount = 0;//presale contributions tracked differently than main sale
        uint256 presalePurchaseTokens = rakugoPresale.balanceOf(presalePurchaseAddress);
        contribute(presalePurchaseAddress, presalePurchaseAddress, contributionAmmount, presalePurchaseTokens);
    }
  }

  function contribute(address purchaser, address beneficiary, uint256 weiAmount, uint256 tokens){
    rakugoToken.create(beneficiary, tokens);
    TokenPurchase(purchaser, beneficiary, weiAmount, tokens);
    weiRaised = weiRaised.add(weiAmount);
  }
}
