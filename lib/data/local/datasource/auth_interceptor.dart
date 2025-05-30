import 'package:bonfire/data/local/datasource/token_manager.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  final TokenManager tokenManager;

  AuthInterceptor(this.tokenManager);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await tokenManager.getToken();
    options.headers['accept'] = '*/*';
    options.headers['Content-Type'] = 'application/json';
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }
}
