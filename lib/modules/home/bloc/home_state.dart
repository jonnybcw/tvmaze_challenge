part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoadSuccess extends HomeState {
  const HomeLoadSuccess({
    required this.pagingController,
  });

  final PagingController<int, SeriesDetails> pagingController;

  @override
  List<Object> get props => [pagingController];
}

class HomeLoadFailure extends HomeState {}
