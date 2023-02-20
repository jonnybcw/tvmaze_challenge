import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tvmaze_challenge/config/hive_config.dart';

part 'series_image.g.dart';

@HiveType(typeId: seriesImageId)
@JsonSerializable()
class SeriesImage extends Equatable {
  const SeriesImage({
    required this.medium,
    required this.original,
  });

  @HiveField(0)
  final String medium;
  @HiveField(1)
  final String original;

  factory SeriesImage.fromJson(Map<String, dynamic> json) =>
      _$SeriesImageFromJson(json);

  Map<String, dynamic> toJson() => _$SeriesImageToJson(this);

  @override
  List<Object?> get props => [medium, original];
}
