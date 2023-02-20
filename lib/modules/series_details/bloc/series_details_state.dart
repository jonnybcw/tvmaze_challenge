part of 'series_details_bloc.dart';

abstract class SeriesDetailsState extends Equatable {
  const SeriesDetailsState({
    required this.seriesDetails,
  });

  final SeriesDetails seriesDetails;

  @override
  List<Object> get props => [
        seriesDetails,
      ];
}

class SeriesDetailsInitial extends SeriesDetailsState {
  const SeriesDetailsInitial({required super.seriesDetails});
}

class SeriesDetailsLoadSuccess extends SeriesDetailsState {
  const SeriesDetailsLoadSuccess({
    required super.seriesDetails,
    required this.seasons,
    required this.currentSeason,
    required this.episodes,
    required this.isFavorite,
  });

  final List<int> seasons;
  final int currentSeason;
  final List<SeriesEpisode> episodes;
  final bool isFavorite;

  @override
  List<Object> get props =>
      super.props +
      [
        seasons,
        currentSeason,
        episodes,
        isFavorite,
      ];
}

class SeriesDetailsLoadFailure extends SeriesDetailsState {
  const SeriesDetailsLoadFailure({required super.seriesDetails});
}
