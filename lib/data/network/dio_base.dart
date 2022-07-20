import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

///Create DioBase
class DioBase {
  ///GetDio
  static Dio instance() {
    final dio = Dio(BaseOptions(
      connectTimeout: 20000,
      receiveTimeout: 20000,
      headers: {
        // 'Content-Type': 'application/json',
        // 'Content-Type': 'application/x-www-form-urlencoded',
        // 'charset': 'utf-8',
        // 'accept': 'application/json'
      },
    ))
      ..interceptors.add(HttpLogInterceptor());

    // Add cache
    getTemporaryDirectory().then((dir) {
      var cacheStore = HiveCacheStore(dir.path);

      var cacheOptions = CacheOptions(
        store: cacheStore,
        maxStale: const Duration(hours: 2),
        hitCacheOnErrorExcept: [], // for offline behaviour
      );

      dio.interceptors.add(DioCacheInterceptor(options: cacheOptions));
    });

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
