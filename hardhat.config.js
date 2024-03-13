/**
 * @type import('hardhat/config').HardhatUserConfig
 */
require ("@nomicfoundation/hardhat-ethers");
require('@nomicfoundation/hardhat-chai-matchers');
require('hardhat-exposed');

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: {
    compilers: [ 
      {
        version: "0.8.24"
      }
    ]
  },
  networks: {
    testnet: {
      url: 'https://polygon-mumbai-bor-rpc.publicnode.com',
      chainId: 80001,
      accounts: ['']
    },
    mainnet: {
      url: 'https://polygon-rpc.com/',
      chainId: 137,
      accounts: ['']
    },
  },
  mocha: {
    timeout: 10000
 },
  exposed: {
    include: ['**/*'],
    exclude: [],
    outDir: 'contracts-exposed',
    prefix: '$',
    imports: true,
    initializers: true,
  }
}
