import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tvmaze_challenge/data/models/person_series_embedded.dart';

part 'cast_credits.g.dart';

@JsonSerializable()
class CastCredits extends Equatable {
  const CastCredits({
    required this.embedded,
  });

  @JsonKey(name: '_embedded')
  final PersonSeriesEmbedded embedded;

  factory CastCredits.fromJson(Map<String, dynamic> json) =>
      _$CastCreditsFromJson(json);

  Map<String, dynamic> toJson() => _$CastCreditsToJson(this);

  @override
  List<Object?> get props => [
        embedded,
      ];
}
