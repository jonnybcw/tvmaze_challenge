import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tvmaze_challenge/data/models/series_image.dart';

part 'series_season.g.dart';

@JsonSerializable()
class SeriesSeason extends Equatable {
  const SeriesSeason({
    required this.id,
    required this.name,
    required this.image,
    required this.summary,
  });

  final int id;
  final String name;
  final SeriesImage image;
  final String? summary;

  factory SeriesSeason.fromJson(Map<String, dynamic> json) =>
      _$SeriesSeasonFromJson(json);

  Map<String, dynamic> toJson() => _$SeriesSeasonToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        image,
        summary,
      ];
}
