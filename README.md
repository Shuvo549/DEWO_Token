# DEWO_Token

This Repo isn't ready just yet, come back soon!



## Requirements


`node v16.14.2(LTS)`<br>
`npm @Latest`<br>
`npm install -g npx`<br>

 


## Deploy


`npm install`<br>
`npm run build`<br>
Deploy $DEWO on BSC Testnet (Chain ID: 97)<br>
`npx truffle migrate --network testnet --reset --f 2 --to 2`<br>
Deploy $DEWO on BSC (Chain ID: 56)<br>
`npx truffle migrate --network bsc --reset --f 1 --to 1`<br>
Verify the contract on Testnet:<br>
`npx truffle run verify DecentraWorld_Testnet@contractaddress  --network testnet`<br>
Verify the contract on BSC:<br>
`npx truffle run verify DecentraWorld@contractaddress  --network bsc`

