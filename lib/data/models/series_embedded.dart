import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tvmaze_challenge/data/models/series_episode.dart';

part 'series_embedded.g.dart';

@JsonSerializable()
class SeriesEmbedded extends Equatable {
  const SeriesEmbedded({
    required this.episodes,
  });

  final List<SeriesEpisode> episodes;

  factory SeriesEmbedded.fromJson(Map<String, dynamic> json) =>
      _$SeriesEmbeddedFromJson(json);

  Map<String, dynamic> toJson() => _$SeriesEmbeddedToJson(this);

  @override
  List<Object?> get props => [
        episodes,
      ];
}
