import 'package:dio/dio.dart';
import 'package:dio_logger/dio_logger.dart';

class HttpClient {
  HttpClient({required this.baseUrl, required this.apiKey});

  final String apiKey;
  final String baseUrl;

  late final _authInterceptor = InterceptorsWrapper(
    onRequest: (options, handler) {
      final concatSymbol = options.path.contains('?') ? '&' : '?';
      final options2 = options.copyWith(
        path: '${options.path}${concatSymbol}key=$apiKey',
      );
      handler.next(options2);
    },
  );

  late final _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: 5000,
    receiveTimeout: 5000,
  ))
    ..interceptors.add(_authInterceptor)
    ..interceptors.add(dioLoggerInterceptor);

  Future<Map<String, dynamic>?> getJson(String endpoint) async {
    final response = await _dio.get<Map<String, dynamic>>(endpoint);
    return response.data;
  }
}
