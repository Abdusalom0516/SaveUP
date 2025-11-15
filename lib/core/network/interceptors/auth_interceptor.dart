import 'dart:developer';
import 'package:boilerplate/core/network/api_endpoints.dart';
import 'package:boilerplate/core/services/token_service.dart';
import 'package:dio/dio.dart';


class AuthInterceptor extends Interceptor {
  final Dio _dio;
  final TokenService _tokenService;
  bool _isRefreshing = false; // prevent multiple refresh calls

  AuthInterceptor(this._dio, this._tokenService);

  bool _isRefreshRequest(RequestOptions options) {
    return options.path.contains(ApiEndpoints.refreshToken);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // 🚫 Don't attach token for refresh request
    if (!_isRefreshRequest(options)) {
      final accessToken = await _tokenService.getAccessToken();
      if (accessToken != null) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
    }

    log('➡️ Sending request: ${options.method} ${options.uri}');
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 🚫 Avoid recursion for refresh request
    if (_isRefreshRequest(err.requestOptions)) {
      handler.next(err);
      return;
    }

    if (err.response?.statusCode == 401) {
      if (_isRefreshing) {
        log('⚠️ Refresh already in progress — rejecting duplicate');
        handler.next(err);
        return;
      }

      _isRefreshing = true;
      final refreshToken = await _tokenService.getRefreshToken();

      if (refreshToken != null) {
        try {
          log('🔄 Trying to refresh token...');
          final response = await _dio.post(
            ApiEndpoints.refreshToken,
            data: {'refreshToken': refreshToken},
            options: Options(headers: {'Accept': 'application/json'}),
          );

          final newAccessToken = response.data['accessToken'];
          final newRefreshToken = response.data['refreshToken'];

          await _tokenService.saveTokens(
            accessToken: newAccessToken,
            refreshToken: newRefreshToken,
          );

          log('✅ Token refreshed successfully');
          _isRefreshing = false;

          final retryResponse = await _retry(err.requestOptions, newAccessToken);
          return handler.resolve(retryResponse);
        } catch (e) {
          log('❌ Refresh token failed: $e');
          _isRefreshing = false;
          await _handleRefreshFailure();
          return handler.reject(err);
        }
      } else {
        log('⚠️ No refresh token found');
        await _handleRefreshFailure();
      }
    }

    handler.next(err);
  }

  Future<void> _handleRefreshFailure() async {
    await _tokenService.clearTokens();
    log('🚪 Session expired, redirecting to Login');
    // AppRouter.open(LoginScreen());
  }

  Future<Response> _retry(RequestOptions requestOptions, String accessToken) async {
    final options = Options(
      method: requestOptions.method,
      headers: {
        ...requestOptions.headers,
        'Authorization': 'Bearer $accessToken',
      },
    );

    return _dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
