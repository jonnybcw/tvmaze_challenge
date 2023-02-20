part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class QueryChanged extends SearchEvent {}

class SeriesLoaded extends SearchEvent {}

class GetSeriesFailed extends SearchEvent {}

class ClearQueryTapped extends SearchEvent {}

class SearchTypeChanged extends SearchEvent {
  const SearchTypeChanged({
    required this.searchType,
  });

  final SearchType searchType;

  @override
  List<Object> get props => [searchType];
}

class RetryTapped extends SearchEvent {}
