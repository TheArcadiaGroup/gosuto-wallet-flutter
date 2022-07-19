import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

///Create DioBase
class DioBase {
  ///GetDio
  static Dio instance() {
    final dio = Dio(BaseOptions(
      connectTimeout: 10000,
      receiveTimeout: 10000,
      headers: {
        // 'Content-Type': 'application/json',
        // 'Content-Type': 'application/x-www-form-urlencoded',
        // 'charset': 'utf-8',
        // 'accept': 'application/json'
      },
    ));

    dio.interceptors.add(HttpLogInterceptor());

    // dio.interceptors.add(PrettyDioLogger(
    //   requestHeader: true,
    //   requestBody: true,
    //   responseBody: true,
    //   responseHeader: true,
    //   error: true,
    //   compact: true,
    //   maxWidth: 1000,
    // ));

    return dio;
  }
}

/// HttpLogInterceptor
class HttpLogInterceptor extends InterceptorsWrapper {}
