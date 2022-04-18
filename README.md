# DEWO_Token

This Repo isn't ready just yet, come back soon!



## Requirements


`node v16.14.2(LTS)`
`npm @Latest`
`npm install -g npx`

 


## Deploy


`npm install`<br>
`npm run build`<br>
`npx truffle migrate --network $network --reset --f 1 --to 1`<br>
Pick any network: bsc, testnet, matic, avalanche, fanton, cronos, matic<br>
`./flatss/` - a testnet ready DecentraWorld.sol contract (with the correct PCS router & pair) 
Verify the contract:<br>
`npx truffle run verify DecentraWorld@contractaddress  --network $network`

