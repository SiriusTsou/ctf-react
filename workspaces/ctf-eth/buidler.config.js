const fs = require('fs')

mnemonic = fs.readFileSync(process.env.MNEMONIC_FILE, 'utf-8')

usePlugin("@nomiclabs/buidler-waffle");
usePlugin("buidler-deploy")

// This is a sample Buidler task. To learn how to create your own go to
// https://buidler.dev/guides/create-task.html
task("accounts", "Prints the list of accounts", async () => {
  const accounts = await ethers.getSigners();

  for (const account of accounts) {
    console.log(await account.getAddress());
  }
});

infura=process.env.INFURA_ID

// You have to export an object to set up your config
// This object can have the following optional entries:
// defaultNetwork, networks, solc, and paths.
// Go to https://buidler.dev/config/ to learn more
module.exports = {
  // This is a sample solc configuration that specifies which version of solc to use
  solc: {
    version: "0.7.6",
  },
  networks: {
    rinkeby: {
      url: `https://rinkeby.infura.io/v3/${infura}`,
      accounts:{mnemonic}
    },
    ropsten: {
      url: `https://ropsten.infura.io/v3/${infura}`,
      accounts:{mnemonic}
    },
    xdai: {
      url: `https://dai.poa.network/`,
      accounts:{mnemonic}
    }
  },
  namedAccounts: {
    deployer: 0,
    metamask: '0xd21934eD8eAf27a67f0A70042Af50A1D6d195E81',

    //official addresses from https://docs.opengsn.org/networks
    forwarder: {
      1: '0xAa3E82b4c4093b4bA13Cb5714382C99ADBf750cA',
      3: '0xeB230bF62267E94e657b5cbE74bdcea78EB3a5AB',
      4: '0x83A54884bE4657706785D7309cf46B58FE5f6e8a'
    }
  }
};
