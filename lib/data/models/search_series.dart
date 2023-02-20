import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tvmaze_challenge/data/models/series_details.dart';

part 'search_series.g.dart';

@JsonSerializable()
class SearchSeries extends Equatable {
  const SearchSeries({
    required this.score,
    required this.show,
  });

  final double score;
  final SeriesDetails show;

  factory SearchSeries.fromJson(Map<String, dynamic> json) =>
      _$SearchSeriesFromJson(json);

  Map<String, dynamic> toJson() => _$SearchSeriesToJson(this);

  @override
  List<Object?> get props => [
        score,
        show,
      ];
}
