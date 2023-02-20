part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState({
    required this.searchController,
    required this.query,
    required this.searchType,
  });

  final TextEditingController searchController;
  final String query;
  final SearchType searchType;

  @override
  List<Object> get props => [
        searchController,
        query,
        searchType,
      ];
}

class SearchInitial extends SearchState {
  const SearchInitial({
    required super.searchController,
    required super.query,
    required super.searchType,
  });
}

class SearchLoadInProgress extends SearchState {
  const SearchLoadInProgress({
    required super.searchController,
    required super.query,
    required super.searchType,
  });
}

class SearchLoadSuccess extends SearchState {
  const SearchLoadSuccess({
    required this.seriesResults,
    required this.peopleResults,
    required super.searchController,
    required super.query,
    required super.searchType,
  });

  final List<SearchSeries> seriesResults;
  final List<SearchPerson> peopleResults;

  @override
  List<Object> get props =>
      super.props +
      [
        seriesResults,
        peopleResults,
      ];
}

class SearchLoadFailure extends SearchState {
  const SearchLoadFailure({
    required super.searchController,
    required super.query,
    required super.searchType,
  });
}
