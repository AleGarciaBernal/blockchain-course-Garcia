require("@nomiclabs/hardhat-waffle");

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.4",
  networks:{
    goerly:{
      url:'https://eth-goerli.g.alchemy.com/v2/doyryVZnBjYt3NNUy7cCi291aW_OA81O',
      accounts:['']
    },
    rinkeby:{
      url:'https://eth-rinkeby.alchemyapi.io/v2/yecPXiXxeb7padF0P0uEIR2SNuGV_BRp',
      accounts:['']
    },
    eth: {
      url:'https://eth-mainnet.g.alchemy.com/v2/q1pQZmOAJkChYaJtmTC6ikfAywKk_8S3',
      accounts:['']
    }

  },
  paths:{
    sources:'./src/ethereum-hardhat/contracts',
    tests:'./src/ethereum-hardhat/test',
    cache:'./src/ethereum-hardhat/cache',
    artifacts:'./src/ethereum-hardhat/artifacts'

  }
};
