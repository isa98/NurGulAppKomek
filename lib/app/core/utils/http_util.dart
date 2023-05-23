import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app.dart';

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() => _instance;

  late Dio dio;
  CancelToken cancelToken = CancelToken();

  HttpUtil._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: const Duration(seconds: 1000000),
      receiveTimeout: const Duration(seconds: 5000000),
      headers: {},
      contentType: 'application/json; charset=utf-8',
    );

    dio = Dio(options);

    // CookieJar cookieJar = CookieJar();
    // dio.interceptors.add(CookieManager(cookieJar));

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Do something before request is sent
          debugPrint(
              'REQUEST [${options.method}] => PATH: ${options.path} => QUERY_PARAMS: ${options.queryParameters} => DATA: ${options.data}');
          return handler.next(options); //continue
        },
        onResponse: (response, handler) {
          // Do something with response data
          return handler.next(response); // continue
          // If you want to terminate the request and trigger an error, you can reject a `DioError` object, such as `handler.reject(error)`,
          // In this way, the request will be aborted and an exception will be triggered, and the upper-level catchError will be called.
        },
        onError: (DioError e, handler) {
          debugPrint('CODE: ${e.response?.statusCode}');
          debugPrint('CODE: ${e.response?.statusMessage}');
          // Do something with response error
          ErrorEntity eInfo = createErrorEntity(e);
          debugPrint('CODE: ${eInfo.code}');
          // override statusMessage
          e.response?.statusMessage = eInfo.message;
          switch (eInfo.code) {
            case 401: // No permission to log in again
              // navigateToLoginScreen();
              // setLoginStatus(false);
              break;
            default:
          }
          return handler.next(e); //continue
          // If you want to complete the request and return some custom data, you can resolve a `Response`, such as `handler.resolve(response)`.
          // In this way, the request will be terminated, the upper then will be called, and the data returned in then will be your custom response.
        },
      ),
    );
  }

/*
    + Error unified processing
    */
  // error message
  ErrorEntity createErrorEntity(DioError error) {
    debugPrint('error response => ${error.response}');
    debugPrint('error response => ${error.type}');

    String? errorMessage;

    if (error.response?.data.containsKey('error')) {
      errorMessage = error.response?.data['error'];
    } else if (error.response?.data.containsKey('errors')) {
      errorMessage = error.response?.data['errors'][0];
    }

    switch (error.type) {
      case DioErrorType.cancel:
        return ErrorEntity(code: -1, message: 'Request cancellation');
      case DioErrorType.connectionTimeout:
        return ErrorEntity(code: -1, message: 'Connection timed out');
      case DioErrorType.sendTimeout:
        return ErrorEntity(code: -1, message: 'Request timed out');
      case DioErrorType.receiveTimeout:
        return ErrorEntity(code: -1, message: 'Response timeout');
      // case DioErrorType.badResponse:
      // return ErrorEntity(code: -1, message: errorMessage ?? 'Response bad request');
      case DioErrorType.badResponse:
        {
          try {
            int? errCode = error.response?.statusCode;
            switch (errCode) {
              case 400:
                return ErrorEntity(code: errCode, message: errorMessage ?? 'Request syntax error');
              case 401:
                return ErrorEntity(code: errCode, message: errorMessage ?? 'Permission denied');
              case 403:
                return ErrorEntity(code: errCode, message: errorMessage ?? 'Server refused to execute');
              case 404:
                return ErrorEntity(code: errCode, message: errorMessage ?? 'Can not reach server');
              case 422:
                return ErrorEntity(code: errCode, message: errorMessage ?? 'Unprocessable content');
              case 405:
                return ErrorEntity(code: errCode, message: errorMessage ?? 'Request method is forbidden');
              case 500:
                return ErrorEntity(code: errCode, message: errorMessage ?? 'Server internal error');
              case 502:
                return ErrorEntity(code: errCode, message: errorMessage ?? 'Invalid request');
              case 503:
                return ErrorEntity(code: errCode, message: errorMessage ?? 'Server hung up');
              case 505:
                return ErrorEntity(code: errCode, message: errorMessage ?? 'Does not support HTTP protocol request');
              default:
                {
                  // return ErrorEntity(code: errCode, message: 'Unknown error');
                  return ErrorEntity(
                    code: errCode,
                    message: error.response?.statusMessage,
                  );
                }
            }
          } on Exception catch (_) {
            // showSnack('error'.tr, 'internet_conn_err'.tr, SnackType.error);
            return ErrorEntity(code: -1, message: 'Unknown error');
          }
        }
      default:
        {
          return ErrorEntity(code: -1, message: error.message);
        }
    }
  }

  /*
    Cancel Request
    The same cancel token can be used for multiple requests. When a cancel token is cancelled,
    all requests using the cancel token will be cancelled. So the parameters are optional
  */
  void cancelRequests(CancelToken token) {
    token.cancel('cancelled');
  }

  Future<Map<String, dynamic>> getAuthorizationHeader() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> headers;
    String? accessToken = prefs.getString(Constants.token);
    headers = {
      'Authorization': 'Bearer $accessToken',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    return headers;
  }

  /// restful get
  /// refresh false
  /// noCache true
  /// list  false
  /// cacheKey
  /// cacheDisk
  Future get({
    required String path,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool refresh = false,
    bool noCache = false,
    bool list = false,
    String cacheKey = '',
    bool cacheDisk = false,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.extra ??= {};
    requestOptions.extra!.addAll({
      'refresh': refresh,
      'noCache': noCache,
      'list': list,
      'cacheKey': cacheKey,
      'cacheDisk': cacheDisk,
    });
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = await getAuthorizationHeader();
    requestOptions.headers!.addAll(authorization);

    var response =
        await dio.get(path, queryParameters: queryParameters, options: requestOptions, cancelToken: cancelToken);
    return response.data;
  }

  /// restful post
  Future post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = await getAuthorizationHeader();
    requestOptions.headers!.addAll(authorization);
    var response = await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  /// restful put
  Future put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = await getAuthorizationHeader();
    requestOptions.headers!.addAll(authorization);
    var response = await dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  /// restful patch
  Future patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = await getAuthorizationHeader();
    requestOptions.headers!.addAll(authorization);
    var response = await dio.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  /// restful delete
  Future delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = await getAuthorizationHeader();
    requestOptions.headers!.addAll(authorization);
    var response = await dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    debugPrint('stop');
    return response.data;
  }

  /// restful post form
/*Future postForm(
    String path, {
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    requestOptions.headers!.addAll(authorization);
    var response = await dio.post(
      path,
      data: FormData.fromMap(data),
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }*/

  /// restful post Stream
/*Future postStream(
    String path, {
    dynamic data,
    int dataLength = 0,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }
    requestOptions.headers!.addAll({
      Headers.contentLengthHeader: dataLength.toString(),
    });
    var response = await dio.post(
      path,
      data: Stream.fromIterable(data.map((e) => [e])),
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  } */
}

// Exception handling
class ErrorEntity implements Exception {
  int? code;
  String? message;

  ErrorEntity({this.code, this.message});

  @override
  String toString() {
    if (message == null) return 'Exception';
    return 'Exception: code $code, $message';
  }
}
