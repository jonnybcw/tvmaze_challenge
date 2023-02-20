import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tvmaze_challenge/data/models/search_person.dart';
import 'package:tvmaze_challenge/data/models/search_series.dart';
import 'package:tvmaze_challenge/data/models/search_type_enum.dart';
import 'package:tvmaze_challenge/data/repositories/people_repository.dart';
import 'package:tvmaze_challenge/data/repositories/shows_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc()
      : super(SearchInitial(
          searchController: TextEditingController(),
          query: '',
          searchType: SearchType.series,
        )) {
    _showsRepository = GetIt.I<ShowsRepository>();
    _peopleRepository = GetIt.I<PeopleRepository>();

    on<SeriesLoaded>((event, emit) {
      emit(_getSuccessState());
    });
    on<GetSeriesFailed>((event, emit) {
      emit(SearchLoadFailure(
        searchController: _searchController,
        query: _searchController.text,
        searchType: _searchType,
      ));
    });
    on<QueryChanged>((event, emit) {
      _searchTextSubject.add(_searchController.text);
      emit(_getLoadInProgressState());
    });
    on<ClearQueryTapped>((event, emit) {
      _searchController.clear();
      _seriesResults = [];
      _peopleResults = [];
      emit(_getInitialState());
    });
    on<SearchTypeChanged>((event, emit) {
      _searchType = event.searchType;
      if (_searchController.text.isEmpty) {
        emit(_getInitialState());
      } else {
        emit(_getLoadInProgressState());
        _getResults();
      }
    });
    on<RetryTapped>((event, emit) {
      emit(_getLoadInProgressState());
      _getResults();
    });

    listeners.add(_searchTextSubject
        .debounce((_) => TimerStream(true, const Duration(milliseconds: 500)))
        .asyncMap((query) {
      _getResults();
    }).listen((_) {}));
  }

  late final ShowsRepository _showsRepository;
  late final PeopleRepository _peopleRepository;
  List<StreamSubscription> listeners = [];
  final BehaviorSubject<String> _searchTextSubject = BehaviorSubject();
  List<SearchSeries> _seriesResults = [];
  List<SearchPerson> _peopleResults = [];
  final TextEditingController _searchController = TextEditingController();
  SearchType _searchType = SearchType.series;

  Future<void> _getResults() async {
    try {
      String query = _searchController.text.trim();
      if (query.isEmpty) {
        _seriesResults = [];
        _peopleResults = [];
      } else {
        if (_searchType == SearchType.series) {
          List<SearchSeries> results = await _showsRepository.searchShows(
            query: query,
          );
          if (query == _searchController.text.trim()) {
            _seriesResults = results;
          }
        } else {
          List<SearchPerson> results = await _peopleRepository.searchPeople(
            query: query,
          );
          if (query == _searchController.text.trim()) {
            _peopleResults = results;
          }
        }
      }
      add(SeriesLoaded());
    } catch (e) {
      add(GetSeriesFailed());
    }
  }

  SearchLoadSuccess _getSuccessState() {
    return SearchLoadSuccess(
      seriesResults: _seriesResults,
      peopleResults: _peopleResults,
      searchController: _searchController,
      query: _searchController.text,
      searchType: _searchType,
    );
  }

  SearchLoadInProgress _getLoadInProgressState() {
    return SearchLoadInProgress(
      searchController: _searchController,
      query: _searchController.text,
      searchType: _searchType,
    );
  }

  SearchInitial _getInitialState() {
    return SearchInitial(
      searchController: _searchController,
      query: _searchController.text,
      searchType: _searchType,
    );
  }

  @override
  Future<void> close() {
    _searchTextSubject.close();
    for (var element in listeners) {
      element.cancel();
    }
    return super.close();
  }
}
