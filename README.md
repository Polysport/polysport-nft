# Polysport NFT

A global standard stablecoin pegged to the US dollar.

GlobalX coin (GPSC) is an ERC-20 token dedicated to making people's financial interactions around the world easier and more flexible, especially within the developing world. GPSC will have different utility cases ranging from storing assets, payment transactions, lending, etc.

_Libraries referenced: OpenZeppelin Upgradeable Contracts, USDT Contracts_
_Licensed under the Apache-2.0 license_

### Features:
##### Standard ERC20 Functionality
All regular accounting, transfer, and allowance methods from the well-known and time-tested ERC-20 token standard.
##### Customizable Transfer Fees
If there's ever a need to take a fee for transfers, this token allows you to set the fee and take a fee for every transfer.
##### Upgradeability
This project uses the standard OpenZeppelin upgradeable contract library.
##### Administration and Roles
This project features a custom implementation of AccessControl.sol from OpenZeppelin. This custom implementation lets there be roles that have only one member. There are also two default roles: super admin and admin.

The ability to renounce one's role has also been removed in favor of role revocation by the role admin only.
##### Stability/Fiat Pegging
With the help of a trusted oracle and a live feed of collateral and fiat reserves, this token can be pegged to any fiat currency using the minting and burning features.
##### Subscriptions
Set an allowance for another address to continually take funds from your account at a specified time period, i.e. a subscription service.
##### Global Transfer Pause
Pause all transfers on the token indefinitely. This is useful for the case when there's a bug that needs to be fixed in the contract code.
##### Whitelist Transfer Pause
Pause all transfers on the token indefinitely with the exception of those on the whitelist. This is useful for the case when there's a bug but need a few active wallets to test with.
##### Blacklist and Asset Freeze
Admins can add a user to the blacklist to stop them from receiving and sending tokens. There is also a confiscation feature that allows admins to confiscate funds from a blacklisted wallet and send them to a specified collection wallet.

### Environment Installation
NodeJS version: 18

`node --version`

NPM version: 9

`npm --version`

### Local Preparation
Enter private keys of the desired deployer wallet in `hardhat.config.js` in the accounts list under the network section (mainnet and testnet).

Compile all source codes:

`yarn hardhat clean`
`yarn hardhat compile`

Run all unit tests to ensure everything works as expected. Open the first terminal and run:

`bash ganache.sh`

Open the second terminal and run tests:

`truffle test --network dev`

_Make sure all tests are passed. Please contact the development team if some tests failed._

### Deployment
Modify the square brackets in the `deployProxy` call in the `deploy.js` script to include the desired parameters to deploy the contract with.

Deploy with hardhat:
`npx hardhat run scripts/deploy.js --network <mainnet/testnet>`

### Upgrades
Make desired changes to source code and complete the local preparation above again.

Enter the address of your deployed proxy in the proxyAddress variable. 

Upgrade with hardhat:
`npx hardhat run scripts/upgrade.js --network <mainnet/testnet>`

### Testing
There are two sets of tests; blackbox and unit.

Blackbox tests are the systems/integration testing.

Unit tests are for testing individual code lines/blocks.

To run the blackbox tests, open up the blackboxTests.txt file and follow the instructions for each individual test. A knowledge of how to interact with smart contracts, MetaMask, and a testnet of your choice are necessary.

To run the unit tests, compile the contracts and run the command:
`npx hardhat test`

All tests should pass. If any do not, please contact the developers ASAP.
