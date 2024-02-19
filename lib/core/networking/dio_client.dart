import 'dart:async';
import 'dart:convert';
import 'dart:io' as IO;
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {

  static Dio getDio({String? token, String? baseUrl}) {
    Dio _dio = Dio(BaseOptions(
      baseUrl: baseUrl ?? '',
      headers: {'Authorization': token},
      contentType: "application/json",
      connectTimeout: 5000,
      receiveTimeout: 5000,
      followRedirects: false,
      validateStatus: (status) {
        return status! < 500;
      },
    ));
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        request: true,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
    return _dio;
  }

}
