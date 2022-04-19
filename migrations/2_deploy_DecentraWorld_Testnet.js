/* global artifacts */
const DecentraWorld = artifacts.require('DecentraWorld_Testnet')

module.exports = async function (deployer) {
  await deployer.deploy(DecentraWorld)
  let block = await web3.eth.getBlock("latest")
  console.log('DecentraWorld_Testnet (', block.number, ') = ',  DecentraWorld_Testnet.address)
}
