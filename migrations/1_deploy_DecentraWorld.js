/* global artifacts */
const DecentraWorld = artifacts.require('DecentraWorld')

module.exports = async function (deployer) {
  await deployer.deploy(DecentraWorld)
  let block = await web3.eth.getBlock("latest")
  console.log('DecentraWorld (', block.number, ') = ',  DecentraWorld.address)
}
