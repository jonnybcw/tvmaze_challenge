import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tvmaze_challenge/data/models/person.dart';

part 'search_person.g.dart';

@JsonSerializable()
class SearchPerson extends Equatable {
  const SearchPerson({
    required this.score,
    required this.person,
  });

  final double score;
  final Person person;

  factory SearchPerson.fromJson(Map<String, dynamic> json) =>
      _$SearchPersonFromJson(json);

  Map<String, dynamic> toJson() => _$SearchPersonToJson(this);

  @override
  List<Object?> get props => [
        score,
        person,
      ];
}
