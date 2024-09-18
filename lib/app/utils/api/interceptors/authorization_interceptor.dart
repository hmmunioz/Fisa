import 'package:dio/dio.dart';

class AuthorizationInterceptor extends Interceptor {
  AuthorizationInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
  }
}
