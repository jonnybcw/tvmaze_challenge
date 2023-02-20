part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class SeriesLoaded extends HomeEvent {}

class GetSeriesFailed extends HomeEvent {}

class RetryTapped extends HomeEvent {}
