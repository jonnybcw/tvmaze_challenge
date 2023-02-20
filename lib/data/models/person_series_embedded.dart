import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tvmaze_challenge/data/models/series_details.dart';

part 'person_series_embedded.g.dart';

@JsonSerializable()
class PersonSeriesEmbedded extends Equatable {
  const PersonSeriesEmbedded({
    required this.show,
  });

  final SeriesDetails show;

  factory PersonSeriesEmbedded.fromJson(Map<String, dynamic> json) =>
      _$PersonSeriesEmbeddedFromJson(json);

  Map<String, dynamic> toJson() => _$PersonSeriesEmbeddedToJson(this);

  @override
  List<Object?> get props => [
        show,
      ];
}
