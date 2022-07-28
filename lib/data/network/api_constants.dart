class APIConstants {
  static const pathAPI = '';

  static const accountTransfers = 'accounts/{accountHash}/transfers';

  static const accountDeploys = 'accounts/{publicKey}/extended-deploys';

  static const deployInfo = 'extended-deploys/{deployHash}';

  static const deployTransfers = 'deploys/{deployHash}/transfers';

  static const rateAmount = 'rates/{rateId}/amount';

  static const marketChart = 'coins/casper-network/market_chart';

  static const casperNetwork = 'coins/casper-network';

  static const stateAuctionInfo = 'rpc/state_get_auction_info';

  static const totalRewards = '{type}/{publicKey}/total-rewards';

  static const accountsInfo = 'accounts-info/{accountHash}/';

  static const uniswapV2Pairs = 'uniswap-v2-pairs/{pairHash}';
}
