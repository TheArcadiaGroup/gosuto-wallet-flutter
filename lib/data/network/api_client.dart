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
  @GET(APIConstants.accountsTransfers)
  Future<ServerResponseModel> accountsTransfers(
      @Path('accountHash') String accountHash,
      @Query('page') int page,
      @Query('limit') int limit,
      @Query('order_direction') String orderDirection,
      @Query('with_extended_info') int withExtendedInfo,
      );
}
