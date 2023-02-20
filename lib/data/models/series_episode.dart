import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tvmaze_challenge/data/models/series_image.dart';

part 'series_episode.g.dart';

@JsonSerializable()
class SeriesEpisode extends Equatable {
  const SeriesEpisode({
    required this.id,
    required this.name,
    required this.season,
    required this.number,
    required this.image,
    required this.summary,
  });

  final int id;
  final String name;
  final int season;
  final int number;
  final SeriesImage? image;
  final String? summary;

  factory SeriesEpisode.fromJson(Map<String, dynamic> json) =>
      _$SeriesEpisodeFromJson(json);

  Map<String, dynamic> toJson() => _$SeriesEpisodeToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        season,
        number,
        image,
        summary,
      ];
}
