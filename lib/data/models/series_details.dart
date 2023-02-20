import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tvmaze_challenge/config/hive_config.dart';
import 'package:tvmaze_challenge/data/models/series_embedded.dart';
import 'package:tvmaze_challenge/data/models/series_image.dart';
import 'package:tvmaze_challenge/data/models/series_schedule.dart';

part 'series_details.g.dart';

@HiveType(typeId: seriesDetailsId)
@JsonSerializable()
class SeriesDetails extends Equatable {
  const SeriesDetails({
    required this.id,
    required this.name,
    required this.genres,
    required this.image,
    required this.summary,
    required this.schedule,
    this.embedded,
  });

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final List<String> genres;
  @HiveField(3)
  final SeriesImage? image;
  @HiveField(4)
  final String? summary;
  @HiveField(5)
  final SeriesSchedule schedule;
  @JsonKey(name: '_embedded')
  final SeriesEmbedded? embedded;

  factory SeriesDetails.fromJson(Map<String, dynamic> json) =>
      _$SeriesDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$SeriesDetailsToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        genres,
        image,
        summary,
        schedule,
        embedded,
      ];

  String get scheduleText {
    List<String> days = schedule.days;
    String time = schedule.time;
    String output = '';
    for (String day in days) {
      output += '${day}s';
      if (days.length > 1) {
        if (day == days[days.length - 2]) {
          output += ' and ';
        } else if (day != days[days.length - 1]) {
          output += ', ';
        }
      }
    }
    if (time.isNotEmpty) {
      output += ' at $time';
    }
    return output;
  }

  String get genresText {
    List<String> genres = this.genres;
    String output = '';
    for (String genre in genres) {
      output += genre;
      if (genre != genres[genres.length - 1]) {
        output += ' | ';
      }
    }
    return output;
  }
}
