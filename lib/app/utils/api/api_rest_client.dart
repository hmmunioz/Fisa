import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fisatest/app/global/env/environment.dart';
import 'package:fisatest/app/utils/api/api_rest_result.dart';
import 'package:fisatest/app/utils/api/interceptors/accept_header_interceptor.dart';

class ApiService {
  // Get time Zone

  static Dio dio = Dio(BaseOptions(
    baseUrl: Environment().config.apiHost,
    contentType: Headers.jsonContentType,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
  ))
    ..interceptors.add(AcceptHeaderInterceptor())
    ..interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        handler.next(options);
      },
    ));
}

enum HttpMethod { get, put, post, delete, patch, formData }

abstract class ApiRestClient {
  void authorization(String? token);

  Future<APIResult> call(
    HttpMethod method,
    String url, {
    Object? body,
    Options options,
  });
}

class ApiRestClientImpl implements ApiRestClient {
  final Dio _httpClient;

  ApiRestClientImpl(
    this._httpClient,
  );

  /// Make the request to api rest [url]
  /// with optional [body] and [options] based on the http [method]
  /// And return [APIResult] object
  @override
  Future<APIResult> call(
    HttpMethod method,
    String url, {
    Object? body,
    Options? options,
  }) {
    switch (method) {
      case HttpMethod.get:
        return _get(
          url,
          options: options,
        );
      case HttpMethod.post:
        return _post(url, body: body, options: options);
      case HttpMethod.put:
        return _put(url, body: body);
      case HttpMethod.delete:
        return _delete(url, body);
      case HttpMethod.patch:
        return _patch(url, body: body);
      case HttpMethod.formData:
        return _formData(url, body as FormData);
      default:
        return _get(url);
    }
  }

  /// Make a http get request to the specific [url]
  Future<APIResult> _get(String url, {Options? options}) async {
    try {
      final response = await _httpClient.get<Object>(
        url,
        options: options?.copyWith(
          responseType: ResponseType.json,
        ),
      );
      return _mapResponse(response);
    } catch (exception) {
      if (exception is DioException) {
        return _mapResponse(exception.response);
      } else {
        return APIResult.error("Uncaught error: $exception");
      }
    }
  }

  /// Make a http post request to the specific [url]
  /// With the specific [body] and [options]
  Future<APIResult> _post(
    String url, {
    Object? body,
    Options? options,
  }) async {
    try {
      final response = await _httpClient.post<Object>(
        url,
        data: body,
        options: options?.copyWith(responseType: ResponseType.json),
      );
      return _mapResponse(response);
    } catch (exception) {
      if (exception is DioException) {
        return _mapResponse(exception.response);
      } else {
        return APIResult.error("Uncaught error: $exception");
      }
    }
  }

  /// Make a http put request to the specific [url]
  /// With the specific [body] and [options]
  Future<APIResult> _put(
    String url, {
    Object? body,
    Options? options,
  }) async {
    try {
      final response = await _httpClient.put<Object>(
        url,
        data: body,
        options: options?.copyWith(responseType: ResponseType.json),
      );
      return _mapResponse(response);
    } catch (exception) {
      if (exception is DioException) {
        return _mapResponse(exception.response);
      } else {
        return APIResult.error("Uncaught error: $exception");
      }
    }
  }

  /// Make a http patch request to the specific [url]
  /// With the specific [body] and [options]
  Future<APIResult> _patch(
    String url, {
    Object? body,
    Options? options,
  }) async {
    try {
      final response = await _httpClient.patch<Object>(
        url,
        data: body,
        options: options?.copyWith(responseType: ResponseType.json),
      );
      return _mapResponse(response);
    } catch (exception) {
      if (exception is DioException) {
        return _mapResponse(exception.response);
      } else {
        return APIResult.error("Uncaught error: $exception");
      }
    }
  }

  /// Make a http delete request to the specific [url]
  Future<APIResult> _delete(String url, Object? body) async {
    try {
      final response = await _httpClient.delete<Object>(
        url,
        options: Options(responseType: ResponseType.json),
        data: body,
      );
      return _mapResponse(response);
    } catch (exception) {
      if (exception is DioException) {
        return _mapResponse(exception.response);
      } else {
        return APIResult.error("Uncaught error: $exception");
      }
    }
  }

  /// Make a http formData request to the specific [url]
  Future<APIResult> _formData(String url, FormData formData) async {
    try {
      final response = await _httpClient.post<Object>(
        url,
        data: formData,
        options: Options(responseType: ResponseType.json),
      );
      return _mapResponse(response);
    } catch (exception) {
      if (exception is DioException) {
        return _mapResponse(exception.response);
      } else {
        return APIResult.error("Uncaught error: $exception");
      }
    }
  }

  /// Map HTTP [Response] object to [APIResult]
  APIResult _mapResponse(Response? response) {
    if (response != null) {
      debugPrint(response.toString());
      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        return APIResult.succeeded(response.data as Object);
      } else {
        return APIResult.failed(response.data as Object);
      }
    } else {
      debugPrint("Unexpected error");
      return const APIResult.error("Unexpected error");
    }
  }

  @override
  void authorization(String? token) {
    // TODO: implement authorization
  }
}
