async function main() {
    const NFTContract = await hre.ethers.getContractFactory("PolysportNFT");
    const nftDeployed = await NFTContract.deploy("https://s3.tebi.io/polysport/", 3, ['1000000000000000', '2000000000000000', '3000000000000000'], [0,0,0], "0x30843A37c1D6d7fc9b6468ff3fB546d9826bBc7d", "0xAE45e9623e801399B6c4976BDb841b879d14f682");
    await nftDeployed.waitForDeployment();
    console.log("NFT Contract deployed to: " + nftDeployed.target);
  }
  
main()
.then(() => process.exit(0))
.catch((error) => {
    console.error(error);
    process.exit(1);
});