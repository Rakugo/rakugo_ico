var RakugoCrowdsale = artifacts.require("./RakugoCrowdsale.sol")

module.exports = function(deployer, network, accounts) {
  const startBlock = web3.eth.blockNumber + 2 // blockchain block number where the crowdsale will commence. Here I just taking the current block that the contract and setting that the crowdsale starts two block after
  const endBlock = startBlock + 300  // blockchain block number where it will end. 300 is little over an hour.
  const cap = new web3.BigNumber(100)
  const wallet = web3.eth.accounts[0] // the address that will hold the fund. Recommended to use a multisig one for security.
  
  deployer.deploy(RakugoCrowdsale, cap, startBlock, endBlock, wallet)
}
