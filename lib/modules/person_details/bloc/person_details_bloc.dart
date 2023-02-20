import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:tvmaze_challenge/data/models/cast_credits.dart';
import 'package:tvmaze_challenge/data/models/person.dart';
import 'package:tvmaze_challenge/data/models/series_details.dart';
import 'package:tvmaze_challenge/data/repositories/people_repository.dart';

part 'person_details_event.dart';
part 'person_details_state.dart';

class PersonDetailsBloc extends Bloc<PersonDetailsEvent, PersonDetailsState> {
  PersonDetailsBloc({required Person person})
      : _person = person,
        super(PersonDetailsInitial(person: person)) {
    _peopleRepository = GetIt.I<PeopleRepository>();

    on<SeriesLoaded>((event, emit) {
      emit(_getPersonDetailsLoadSuccess());
    });
    on<GetSeriesFailed>((event, emit) {
      emit(PersonDetailsLoadFailure(person: person));
    });
    on<RetryTapped>((event, emit) {
      emit(PersonDetailsInitial(person: person));
      _getSeries();
    });

    _getSeries();
  }

  final Person _person;
  late final PeopleRepository _peopleRepository;
  List<SeriesDetails> _series = [];

  Future<void> _getSeries() async {
    try {
      List<CastCredits> castCredits =
          await _peopleRepository.getPersonCastCredits(
        personId: _person.id,
      );
      _series = castCredits.map((e) => e.embedded.show).toList();
      add(SeriesLoaded());
    } catch (e) {
      add(GetSeriesFailed());
    }
  }

  PersonDetailsLoadSuccess _getPersonDetailsLoadSuccess() {
    return PersonDetailsLoadSuccess(
      person: _person,
      series: _series,
    );
  }
}
