import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

class ApiService {
  static Dio? _dio;

  static Future<Dio> getInstance() async {
    if (_dio == null) {
      _dio = Dio();

      // Add cache interceptor with default in-memory store
      _dio!.interceptors.add(
        DioCacheInterceptor(
          options: CacheOptions(
            store: MemCacheStore(),
            policy: CachePolicy.request,
            hitCacheOnErrorExcept: [401, 403],
            maxStale: const Duration(days: 7),
            priority: CachePriority.normal,
            cipher: null,
            keyBuilder: CacheOptions.defaultCacheKeyBuilder,
            allowPostMethod: false,
          ),
        ),
      );

      // Add logging interceptor for debugging (only in debug mode)
      assert(() {
        _dio!.interceptors.add(
          LogInterceptor(
            request: true,
            requestHeader: false,
            requestBody: false,
            responseHeader: false,
            responseBody: true,
            error: true,
          ),
        );
        return true;
      }());
    }
    return _dio!;
  }

  // Method to force refresh (bypass cache)
  static Future<Response> forceRefresh(String url) async {
    final dio = await getInstance();
    return dio.get(
      url,
      options: Options(
        extra: {
          'dio_cache_interceptor': CacheOptions(
            store: MemCacheStore(),
            policy: CachePolicy.refresh,
          ).toExtra(),
        },
      ),
    );
  }
}
