part of 'person_details_bloc.dart';

abstract class PersonDetailsEvent extends Equatable {
  const PersonDetailsEvent();

  @override
  List<Object?> get props => [];
}

class SeriesLoaded extends PersonDetailsEvent {}

class GetSeriesFailed extends PersonDetailsEvent {}

class RetryTapped extends PersonDetailsEvent {}
