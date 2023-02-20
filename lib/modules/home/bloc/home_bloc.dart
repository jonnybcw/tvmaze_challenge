import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tvmaze_challenge/data/models/series_details.dart';
import 'package:tvmaze_challenge/data/repositories/shows_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    _showsRepository = GetIt.I<ShowsRepository>();

    on<SeriesLoaded>((event, emit) {
      emit(HomeLoadSuccess(
        pagingController: _pagingController,
      ));
    });
    on<GetSeriesFailed>((event, emit) {
      emit(HomeLoadFailure());
    });
    on<RetryTapped>((event, emit) {
      emit(HomeInitial());
      _getSeries(pageIndex: 1);
    });

    _pagingController.addPageRequestListener((pageIndex) {
      _getSeries(pageIndex: pageIndex);
    });

    _getSeries(pageIndex: 1);
  }

  late final ShowsRepository _showsRepository;
  final PagingController<int, SeriesDetails> _pagingController =
      PagingController<int, SeriesDetails>(firstPageKey: 1);
  final List<SeriesDetails> _series = [];

  Future<void> _getSeries({required int pageIndex}) async {
    try {
      List<SeriesDetails> series = await _showsRepository.getShowsList(
        pageIndex: pageIndex,
      );
      _updatePagingController(series, pageIndex);
    } catch (e) {
      add(GetSeriesFailed());
    }
  }

  void _updatePagingController(
    List<SeriesDetails> series,
    int pageIndex,
  ) {
    if (pageIndex == 1) _series.clear();

    _series.addAll(series);
    _pagingController.value = PagingState(
      itemList: _series,
      nextPageKey: pageIndex + 1,
    );

    add(SeriesLoaded());
  }
}
