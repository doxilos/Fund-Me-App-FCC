const networkConfig = {
  // Rinkeby is no longer used
  4: {
    name: "rinkeby",
    ethUsdPriceFeed: "0x00", // Rinkeby is deprecieated so use Sepolia instead
  },
  // Polygon Mainnet
  137: {
    name: "polygon",
    ethUsdPriceFeed: "0xF9680D99D6C9589e2a93a78A04A279e509205945",
  },
  // Sepolia Testnet
  11155111: {
    name: "sepolia",
    ethUsdPriceFeed: "0x694AA1769357215DE4FAC081bf1f309aDC325306",
  },
};

const developmentChains = ["hardhat", "localhost"];

// Config for Mock deployment
const DECIMALS = 8;
const INITIAL_ANSWER = 200000000000;

module.exports = {
  networkConfig,
  developmentChains,
  DECIMALS,
  INITIAL_ANSWER,
};
