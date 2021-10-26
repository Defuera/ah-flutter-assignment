import 'package:dio/dio.dart';
import 'package:dio_logger/dio_logger.dart';

class HttpClient {
  HttpClient({required this.apiKey});

  final String apiKey;

  late final _authInterceptor = InterceptorsWrapper(
    onRequest: (options, handler) {
      handler.next(options.copyWith(
        path: options.path.replaceAll('[key]', apiKey),
      ));
    },
  );

  late final _dio = Dio(BaseOptions(
    // if I was an adult I could consider providing base url depending on build flavor 🤔
    baseUrl: 'http://partnerapi.funda.nl/',
    connectTimeout: 5000,
    receiveTimeout: 5000,
  ))
    ..interceptors.add(dioLoggerInterceptor)
    ..interceptors.add(_authInterceptor);

  Future<Map<String, dynamic>?> getJson(String endpoint) async {
    final response = await _dio.get<Map<String, dynamic>>(endpoint);
    return response.data;
  }
}
