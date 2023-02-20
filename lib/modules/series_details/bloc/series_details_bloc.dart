import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:tvmaze_challenge/data/models/series_details.dart';
import 'package:tvmaze_challenge/data/models/series_episode.dart';
import 'package:tvmaze_challenge/data/repositories/shows_repository.dart';

part 'series_details_event.dart';
part 'series_details_state.dart';

class SeriesDetailsBloc extends Bloc<SeriesDetailsEvent, SeriesDetailsState> {
  SeriesDetailsBloc({required SeriesDetails seriesDetails})
      : _seriesDetails = seriesDetails,
        super(SeriesDetailsInitial(seriesDetails: seriesDetails)) {
    _showsRepository = GetIt.I<ShowsRepository>();

    on<EpisodesLoaded>((event, emit) {
      emit(_getSeriesDetailsLoadSuccess());
    });
    on<GetEpisodesFailed>((event, emit) {
      emit(SeriesDetailsLoadFailure(seriesDetails: seriesDetails));
    });
    on<SeasonTapped>((event, emit) {
      _currentSeason = event.season;
      emit(_getSeriesDetailsLoadSuccess());
    });
    on<FavoriteButtonTapped>((event, emit) {
      if (_isFavorite) {
        _removeShowFromFavorites();
      } else {
        _saveShowAsFavorite();
      }
      _isFavorite = !_isFavorite;
      emit(_getSeriesDetailsLoadSuccess());
    });
    on<RetryTapped>((event, emit) {
      emit(SeriesDetailsInitial(seriesDetails: seriesDetails));
      _getEpisodes();
    });

    _checkFavoriteStatus().then((_) {
      List<SeriesEpisode>? episodes = seriesDetails.embedded?.episodes;
      if (episodes != null) {
        _splitEpisodesBySeason(episodes);
      } else {
        _getEpisodes();
      }
    });
  }

  final SeriesDetails _seriesDetails;
  late final ShowsRepository _showsRepository;
  Map<int, List<SeriesEpisode>> _episodesBySeason = {};
  List<int> _seasons = [];
  int _currentSeason = 1;
  bool _isFavorite = false;

  Future<void> _getEpisodes() async {
    try {
      List<SeriesEpisode> episodes = await _showsRepository.getShowEpisodes(
        showId: _seriesDetails.id,
      );
      _splitEpisodesBySeason(episodes);
    } catch (e) {
      add(GetEpisodesFailed());
    }
  }

  Future<void> _splitEpisodesBySeason(List<SeriesEpisode> episodes) async {
    _episodesBySeason = groupBy(episodes, (show) {
      return show.season;
    });

    _seasons = _episodesBySeason.keys.toList();
    _currentSeason = _seasons.firstOrNull ?? 1;
    add(EpisodesLoaded());
  }

  SeriesDetailsLoadSuccess _getSeriesDetailsLoadSuccess() {
    return SeriesDetailsLoadSuccess(
      seriesDetails: _seriesDetails,
      seasons: _seasons,
      currentSeason: _currentSeason,
      episodes: _episodesBySeason[_currentSeason] ?? [],
      isFavorite: _isFavorite,
    );
  }

  Future<void> _checkFavoriteStatus() async {
    List<SeriesDetails> favoriteSeries =
        await _showsRepository.getFavoriteShows();
    SeriesDetails? series = favoriteSeries
        .firstWhereOrNull((element) => element.id == _seriesDetails.id);
    if (series == null) {
      _isFavorite = false;
    } else {
      _isFavorite = true;
    }
  }

  Future<void> _saveShowAsFavorite() async {
    await _showsRepository.saveShowAsFavorite(seriesDetails: _seriesDetails);
  }

  Future<void> _removeShowFromFavorites() async {
    await _showsRepository.removeShowFromFavorites(seriesId: _seriesDetails.id);
  }
}
