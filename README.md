# DEWO_Token

- Read the security audit at [SmartContract_Audit_Solidproof_DecentraWorld.pdf]
- Download this folder to your local machine.


## Requirements


`node v16.14.2(LTS)`<br>
`npm @Latest`<br>
`npm install -g npx`<br>


 

## Initialize

1. `npm install`
2. `npm run build`
3. `cp .env.example .env`




## Deploy DecentraMix.sol native token 
 
Deploy $DEWO on BSC (Chain ID: 56)<br>
`npx truffle migrate --network bsc --reset --f 1 --to 1`<br> 
Verify the contract on BSC:<br>
`npx truffle run verify DecentraWorld@contractaddress  --network bsc`<br>




## Deploy DecentraMix_Multichain.sol cross-chain token 

Available for AVAX, FTM, CRO, ETH, MATIC, TESTNET, and more can be added at `truffle-config.js` <br>
Deploy $DEWO on any of the supported networks by replacing $NETWORK with its name.
`npx truffle migrate --network $NETWORK --reset --f 2 --to 2`<br> 




## Verify DecentraMix.sol through Truffle
1. `cp secret.json.example secret.json`
2. Edit `secret.json` parameters (API keys for each explorer)
3. `npx truffle run verify DecentraWorld@contractaddress  --network $NETWORK`


## Verify DecentraMix.sol Through Explorer
npm install truffle-flattener -g
npx truffle-flattener ./contracts/DecentraMix.sol > ./contracts/DecentraMix_Flat.sol
npx truffle-flattener ./contracts/DecentraMix_Multichain.sol > ./contracts/DecentraMix_Multichain_Flat.sol
Go on the relevant explorer (E.g.: cronoscan.com)
Confirm your contract as a single solidity file 
