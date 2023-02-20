part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class FavoriteSeriesLoaded extends FavoritesEvent {}

class GetFavoriteSeriesFailed extends FavoritesEvent {}

class DeleteSeriesTapped extends FavoritesEvent {
  const DeleteSeriesTapped({
    required this.seriesId,
  });

  final int seriesId;

  @override
  List<Object> get props => [seriesId];
}

class RetryTapped extends FavoritesEvent {}
