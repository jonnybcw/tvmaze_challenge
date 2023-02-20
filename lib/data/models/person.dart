import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tvmaze_challenge/data/models/series_image.dart';

part 'person.g.dart';

@JsonSerializable()
class Person extends Equatable {
  const Person({
    required this.id,
    required this.name,
    required this.image,
  });

  final int id;
  final String name;
  final SeriesImage? image;

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        image,
      ];
}
