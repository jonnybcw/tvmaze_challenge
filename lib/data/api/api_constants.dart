import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

class ApiConstants {
  static String shows(String? params) =>
      '/shows${params == null || params.isEmpty ? '' : '?$params'}';
  static String showDetails(int showId, {String? params}) =>
      '/shows/$showId?embed=episodes';
  static String showEpisodes(int showId, {String? params}) =>
      '/shows/$showId/episodes${params == null || params.isEmpty ? '' : '?$params'}';
  static String showsSearch(String query) => '/search/shows?q=$query';
  static String peopleSearch(String query) => '/search/people?q=$query';
  static String castCredits(int personId) =>
      '/people/$personId/castcredits?embed=show';

  static const String baseURL = 'https://api.tvmaze.com';

  static Dio getDioClient([String? customUrl]) {
    var options = BaseOptions(
      baseUrl: customUrl ?? baseURL,
      connectTimeout: 60000,
      receiveTimeout: 60000,
    );
    Dio dio = Dio(options);
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        log('REQUEST[${options.method}] => PATH: ${options.baseUrl}${options.path}\n OPTIONS ${options.headers}\n DATA ${options.data} ');
        handler.next(options);
      },
      onResponse: (response, handler) async {
        log('RESPONSE[${response.requestOptions.method}] => PATH: ${response.requestOptions.path} [${response.statusCode}]\nBODY:\n${jsonEncode(response.data)}\nHEADERS \n${response.headers}\n');
        handler.next(response);
      },
      onError: (error, handler) async {
        log('ERROR -> ${error.response}');
        handler.next(error);
      },
    ));
    return dio;
  }
}
