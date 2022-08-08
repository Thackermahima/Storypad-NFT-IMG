require("dotenv").config({ path: "./.env" });
require("@nomiclabs/hardhat-waffle");

const pk_1 = process.env.REACT_APP_PRIVATE_KEY;
console.log(pk_1);
module.exports = {
  solidity: "0.8.4",
  networks: {
    hardhat: {},
    mumbai: {
      url: `https://polygon-mumbai.g.alchemy.com/v2/jKmzc-2X15D5tE3FrPvsEynO6bnh0FSm`,

      accounts: [pk_1],
    },
  },
};