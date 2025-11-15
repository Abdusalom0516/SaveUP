import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dio/dio.dart';

import '../exceptions/network_exceptions.dart';

part 'api_response.freezed.dart';

@freezed
abstract class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse.success(T data, {Response<dynamic>? response}) =
      _Success<T>;

  const factory ApiResponse.error(
    NetworkExceptions error, {
    Response<dynamic>? response,
  }) = _Error<T>;
}
