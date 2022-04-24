/* global artifacts */
const DecentraWorld_Multichain = artifacts.require('DecentraWorld_Multichain')

module.exports = async function (deployer) {
  await deployer.deploy(DecentraWorld_Multichain)
  let block = await web3.eth.getBlock("latest")
  console.log('DecentraWorld_Multichain (', block.number, ') = ',  DecentraWorld_Multichain.address)
}
