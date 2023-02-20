import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:tvmaze_challenge/config/hive_config.dart';
import 'package:tvmaze_challenge/data/api/api_constants.dart';
import 'package:tvmaze_challenge/data/api/shows_api.dart';
import 'package:tvmaze_challenge/data/models/search_series.dart';
import 'package:tvmaze_challenge/data/models/series_details.dart';
import 'package:tvmaze_challenge/data/models/series_episode.dart';
import 'package:tvmaze_challenge/util/helpers/query_builder.dart';

class ShowsRepository {
  final Dio _client = ApiConstants.getDioClient();

  Future<List<SeriesDetails>> getShowsList({
    required int pageIndex,
  }) async {
    List<SeriesDetails> showsList = await ShowsApi.getShowsList(
      client: _client,
      query: QueryBuilder.generateQueryWithMap(
        params: {
          'page': pageIndex,
        },
      ),
    );
    return showsList;
  }

  Future<SeriesDetails> getShowDetails({
    required int showId,
  }) async {
    SeriesDetails showDetails = await ShowsApi.getShowDetails(
      client: _client,
      showId: showId,
    );
    return showDetails;
  }

  Future<List<SeriesEpisode>> getShowEpisodes({
    required int showId,
  }) async {
    List<SeriesEpisode> episodes = await ShowsApi.getShowEpisodes(
      client: _client,
      showId: showId,
    );
    return episodes;
  }

  Future<List<SearchSeries>> searchShows({
    required String query,
  }) async {
    List<SearchSeries> episodes = await ShowsApi.searchShows(
      client: _client,
      query: query,
    );
    return episodes;
  }

  Future<List<SeriesDetails>> getFavoriteShows() async {
    Box<SeriesDetails> favoriteSeriesBox =
        await HiveConfig.getFavoriteSeriesBox();
    List<SeriesDetails> series = favoriteSeriesBox.values.toList();
    series.sort((a, b) => a.name.compareTo(b.name));
    return series;
  }

  Future<void> saveShowAsFavorite({
    required SeriesDetails seriesDetails,
  }) async {
    Box<SeriesDetails> favoriteSeriesBox =
        await HiveConfig.getFavoriteSeriesBox();
    await favoriteSeriesBox.put(seriesDetails.id, seriesDetails);
  }

  Future<void> removeShowFromFavorites({
    required int seriesId,
  }) async {
    Box<SeriesDetails> favoriteSeriesBox =
        await HiveConfig.getFavoriteSeriesBox();
    await favoriteSeriesBox.delete(seriesId);
  }
}
