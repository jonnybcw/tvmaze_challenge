part of 'favorites_bloc.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object?> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoadSuccess extends FavoritesState {
  const FavoritesLoadSuccess({
    required this.series,
  });

  final List<SeriesDetails> series;

  @override
  List<Object> get props => [series];
}

class FavoritesLoadFailure extends FavoritesState {}
