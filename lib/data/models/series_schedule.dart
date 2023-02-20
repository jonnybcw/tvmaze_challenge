import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tvmaze_challenge/config/hive_config.dart';

part 'series_schedule.g.dart';

@HiveType(typeId: seriesScheduleId)
@JsonSerializable()
class SeriesSchedule extends Equatable {
  const SeriesSchedule({
    required this.time,
    required this.days,
  });

  @HiveField(0)
  final String time;
  @HiveField(1)
  final List<String> days;

  factory SeriesSchedule.fromJson(Map<String, dynamic> json) =>
      _$SeriesScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$SeriesScheduleToJson(this);

  @override
  List<Object?> get props => [time, days];
}
