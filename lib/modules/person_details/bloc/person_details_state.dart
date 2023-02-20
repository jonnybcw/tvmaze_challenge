part of 'person_details_bloc.dart';

abstract class PersonDetailsState extends Equatable {
  const PersonDetailsState({
    required this.person,
  });

  final Person person;

  @override
  List<Object> get props => [
        person,
      ];
}

class PersonDetailsInitial extends PersonDetailsState {
  const PersonDetailsInitial({required super.person});
}

class PersonDetailsLoadSuccess extends PersonDetailsState {
  const PersonDetailsLoadSuccess({
    required super.person,
    required this.series,
  });

  final List<SeriesDetails> series;

  @override
  List<Object> get props => super.props + [series];
}

class PersonDetailsLoadFailure extends PersonDetailsState {
  const PersonDetailsLoadFailure({required super.person});
}
