import 'package:dio/dio.dart';
import 'package:gosuto/data/network/api_constants.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/models.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET(APIConstants.rateAmount)
  Future<ServerResponseModel> rateAmount(@Path('rateId') int rateId);

  // page=1&limit=10&order_direction=DESC&with_extended_info=1
  @GET(APIConstants.accountTransfers)
  Future<ServerResponseModel> accountTransfers(
    @Path('accountHash') String accountHash, [
    @Query('page') int page = 1,
    @Query('limit') int limit = 10,
    @Query('order_direction') String orderDirection = 'DESC',
    @Query('with_extended_info') int withExtendedInfo = 1,
  ]);
  // extended-deploys?with_amounts_in_currency_id=1&page=1&limit=10&fields=entry_point,contract_package
  @GET(APIConstants.accountDeploys)
  Future<ServerResponseModel> accountDeploys(
    @Path('publicKey') String publicKey, [
    @Query('page') int page = 1,
    @Query('limit') int limit = 10,
    @Query('with_amounts_in_currency_id') int withAmountsInCurrencyId = 1,
    @Query('fields') String fields = 'entry_point,contract_package',
  ]);

  @GET(APIConstants.marketChart)
  Future<CoingeckoResponseModel> marketChart(
      @Query('vs_currency') String vsCurrency, @Query('days') int days);

  @GET(APIConstants.casperNetwork)
  Future<CoingeckoResponseModel> casperNetwork();

  @GET(APIConstants.stateAuctionInfo)
  Future<dynamic> stateAuctionInfo();

  @GET(APIConstants.totalRewards)
  Future<dynamic> totalRewards(
      @Path('publicKey') String publicKey, @Path('type') String type);

  @GET(APIConstants.accountsInfo)
  Future<dynamic> accountsInfo(@Path('accountHash') String accountHash);
}
