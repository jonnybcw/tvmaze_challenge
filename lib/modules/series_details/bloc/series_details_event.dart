part of 'series_details_bloc.dart';

abstract class SeriesDetailsEvent extends Equatable {
  const SeriesDetailsEvent();

  @override
  List<Object?> get props => [];
}

class EpisodesLoaded extends SeriesDetailsEvent {}

class GetEpisodesFailed extends SeriesDetailsEvent {}

class SeasonTapped extends SeriesDetailsEvent {
  const SeasonTapped({required this.season});

  final int season;

  @override
  List<Object?> get props => [season];
}

class FavoriteButtonTapped extends SeriesDetailsEvent {}

class RetryTapped extends SeriesDetailsEvent {}
