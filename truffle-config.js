require('dotenv').config()
const HDWalletProvider = require('@truffle/hdwallet-provider')
const utils = require('web3-utils')
const {BSCSCANAPIKEY, FTMSCANAPIKEY, ETHERSCANAPIKEY, CRONOSCANAPIKEY, POLYGONSCANAPIKEY, SNOWTRACEAPIKEY} = require('./secret.json');
module.exports = {
  /**
   * Networks define how you connect to your ethereum client and let you set the
   * defaults web3 uses to send transactions. If you don't specify one truffle
   * will spin up a development blockchain for you on port 9545 when you
   * run `develop` or `test`. You can ask a truffle command to use a specific
   * network from the command line, e.g
   *
   * $ truffle test --network <network-name>
   */
               
  // Easily verify any contract on any of our supported chains.
  // npx truffle run verify DeMixFactory@ DeMixToken@ --network testnet
  
  // npx truffle run verify DeMixToken@ --network testnet
  // npx truffle run verify DeMixFactory@ DeMixToken@ Verifier@ --network testnet
  
  // npx truffle run verify ContractName@ContractAddress --network $NetworkName
  // API Keys of explorers
 plugins: [
    'truffle-plugin-verify'
  ],
  api_keys: {
    bscscan: BSCSCANAPIKEY, // BSC API for Testnet & Mainnet
    etherscan: ETHERSCANAPIKEY,
    ftmscan: FTMSCANAPIKEY,
    cronoscan: CRONOSCANAPIKEY,
    snowtrace: SNOWTRACEAPIKEY,
    polygonscan: POLYGONSCANAPIKEY
  },
  

  networks: {
    development: {
      host: '127.0.0.1', // Localhost (default: none)
      port: 8545, // Standard Ethereum port (default: none)
      network_id: '97', // Any network (default: none)
    },

    // All networks that DecentraWorld apps are supporting
    // BSC(56), CRO(25), FTM(250), MATIC(137), Testnet(97), ETH(1), AVAX(43114)
    // Troubleshooting: if you are experiencing connection errors at deployment, use confirmations, networkchecktimeout & timeoutblocks.
    // RPC Connection Issues: Go to https://chainlist.org/ & replace the failing RPC with a responsive one.
    testnet: {
      provider: () => new HDWalletProvider(process.env.PRIVATE_KEY, 'https://data-seed-prebsc-1-s1.binance.org:8545/'),
      network_id: 97,
      gas: 6000000,
      gasPrice: utils.toWei('10', 'gwei'),
      // confirmations: 5,
      // timeoutBlocks: 200,
      skipDryRun: true
    },
    bsc: {
      provider: () => new HDWalletProvider(process.env.PRIVATE_KEY, 'wss://bsc-ws-node.nariox.org:443'),
      network_id: 56,
      gasPrice: utils.toWei('6', 'gwei'),
      //confirmations: 2,
      networkCheckTimeout: 1000000,
      timeoutBlocks: 200,
      skipDryRun: true
    },
    cronos: {
      provider: () => new HDWalletProvider(process.env.PRIVATE_KEY, 'https://evm-cronos.crypto.org/'),
      network_id: 25,
      gasPrice: utils.toWei('5205', 'gwei'),
      // confirmations: 0,
      networkCheckTimeout: 50000000,
      timeoutBlocks: 200,
      skipDryRun: true
    },
    fantom: {
      provider: () => new HDWalletProvider(process.env.PRIVATE_KEY, 'https://rpc.fantom.network'),
      network_id: 250,
      gas: 6000000,
      gasPrice: utils.toWei('620', 'gwei'),
      // confirmations: 0,
      networkCheckTimeoutnetworkCheckTimeout: 10000,
      timeoutBlocks: 200,
      skipDryRun: true
    },
    matic: {
      provider: () => new HDWalletProvider(process.env.PRIVATE_KEY, 'https://polygon-rpc.com/'),
      network_id: 137,
      gas: 6000000,
      gasPrice: utils.toWei('55', 'gwei'),
      // confirmations: 0,
      networkCheckTimeout: 10000000,
      timeoutBlocks: 200,
      skipDryRun: true
    },
    avalanche: {
      provider: () => new HDWalletProvider(process.env.PRIVATE_KEY, 'https://api.avax.network/ext/bc/C/rpc'),
      network_id: 43114,
      gas: 8000000,
      gasPrice: utils.toWei('105', 'gwei'),
      // confirmations: 0,
      networkCheckTimeout: 10000000,
      timeoutBlocks: 200,
      skipDryRun: true
    },
    mainnet: {
      provider: () => new HDWalletProvider(process.env.PRIVATE_KEY, 'https://cloudflare-eth.com'),
      network_id: 1,
      gas: 3000000,
      gasPrice: utils.toWei('55', 'gwei'),
      // confirmations: 0,
      networkCheckTimeout: 1000000,
      timeoutBlocks: 200,
      skipDryRun: true
    },
  },

  mocha: {
    //timeout: 100000
  },

  // Configure your compilers
  compilers: {
    solc: {
      version: '0.8.7', 
      settings: {
        optimizer: {
          enabled: true,
          runs: 200,
        },
      },
    },
  },
}