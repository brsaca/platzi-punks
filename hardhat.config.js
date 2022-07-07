require("@nomiclabs/hardhat-waffle");
require('dotenv').config()

const RINKEBY_RPC_URL = process.env.RINKEBY_RPC_URL;
const PRIVATE_KEY = process.env.PRIVATE_KEY;

module.exports = {
  solidity: "0.8.4",
  networks: {
    rinkeby: {
      url: RINKEBY_RPC_URL,
      accounts: [
        PRIVATE_KEY
      ],
    }
  }
};
