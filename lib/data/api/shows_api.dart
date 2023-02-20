import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tvmaze_challenge/data/api/api_constants.dart';
import 'package:tvmaze_challenge/data/models/search_series.dart';
import 'package:tvmaze_challenge/data/models/series_details.dart';
import 'package:tvmaze_challenge/data/models/series_episode.dart';

class ShowsApi {
  static Future<List<SeriesDetails>> getShowsList({
    required Dio client,
    required String query,
  }) async {
    try {
      final Response response = await client.get(ApiConstants.shows(query));
      List<SeriesDetails> series = [];
      for (Map<String, dynamic> show in response.data) {
        series.add(SeriesDetails.fromJson(show));
      }
      return series;
    } catch (error, stacktrace) {
      log('$error', name: 'getShowsList', stackTrace: stacktrace, error: error);
      rethrow;
    }
  }

  static Future<SeriesDetails> getShowDetails({
    required Dio client,
    required int showId,
  }) async {
    try {
      final Response response =
          await client.get(ApiConstants.showDetails(showId));
      return SeriesDetails.fromJson(response.data);
    } catch (error, stacktrace) {
      log('$error',
          name: 'getShowDetails', stackTrace: stacktrace, error: error);
      rethrow;
    }
  }

  static Future<List<SeriesEpisode>> getShowEpisodes({
    required Dio client,
    required int showId,
    bool includeSpecials = false,
  }) async {
    try {
      final Response response = await client.get(ApiConstants.showEpisodes(
        showId,
        params: includeSpecials ? '?specials=1' : null,
      ));
      List<SeriesEpisode> episodes = [];
      for (Map<String, dynamic> show in response.data) {
        episodes.add(SeriesEpisode.fromJson(show));
      }
      return episodes;
    } catch (error, stacktrace) {
      log('$error',
          name: 'getShowEpisodes', stackTrace: stacktrace, error: error);
      rethrow;
    }
  }

  static Future<List<SearchSeries>> searchShows({
    required Dio client,
    required String query,
  }) async {
    try {
      final Response response =
          await client.get(ApiConstants.showsSearch(query));
      List<SearchSeries> shows = [];
      for (Map<String, dynamic> show in response.data) {
        shows.add(SearchSeries.fromJson(show));
      }
      return shows;
    } catch (error, stacktrace) {
      log('$error', name: 'searchShows', stackTrace: stacktrace, error: error);
      rethrow;
    }
  }
}
