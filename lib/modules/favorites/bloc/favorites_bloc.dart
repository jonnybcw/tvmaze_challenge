import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:tvmaze_challenge/data/models/series_details.dart';
import 'package:tvmaze_challenge/data/repositories/shows_repository.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesInitial()) {
    _showsRepository = GetIt.I<ShowsRepository>();

    on<FavoriteSeriesLoaded>((event, emit) {
      emit(FavoritesLoadSuccess(
        series: _series,
      ));
    });
    on<GetFavoriteSeriesFailed>((event, emit) {
      emit(FavoritesLoadFailure());
    });
    on<DeleteSeriesTapped>((event, emit) {
      emit(FavoritesInitial());
      _removeShowFromFavorites(seriesId: event.seriesId);
      _getFavoriteSeries();
    });
    on<RetryTapped>((event, emit) {
      emit(FavoritesInitial());
      _getFavoriteSeries();
    });

    _getFavoriteSeries();
  }

  late final ShowsRepository _showsRepository;
  List<SeriesDetails> _series = [];

  Future<void> _getFavoriteSeries() async {
    try {
      List<SeriesDetails> series = await _showsRepository.getFavoriteShows();
      _series = series;
      add(FavoriteSeriesLoaded());
    } catch (e) {
      add(GetFavoriteSeriesFailed());
    }
  }

  Future<void> _removeShowFromFavorites({required int seriesId}) async {
    await _showsRepository.removeShowFromFavorites(seriesId: seriesId);
  }
}
