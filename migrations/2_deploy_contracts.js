var RakugoPresale = artifacts.require("./RakugoPresale.sol")

module.exports = function(deployer, network, accounts) {
  const startBlock = web3.eth.blockNumber + 2
  const endBlock = startBlock + 300
  const rate = new web3.BigNumber(1200)
  const wallet = web3.eth.accounts[0]

  deployer.deploy(RakugoPresale, startBlock, endBlock, rate, wallet)
}
