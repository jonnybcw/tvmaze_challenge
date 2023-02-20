// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series_schedule.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SeriesScheduleAdapter extends TypeAdapter<SeriesSchedule> {
  @override
  final int typeId = 3;

  @override
  SeriesSchedule read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SeriesSchedule(
      time: fields[0] as String,
      days: (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, SeriesSchedule obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.time)
      ..writeByte(1)
      ..write(obj.days);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeriesScheduleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeriesSchedule _$SeriesScheduleFromJson(Map<String, dynamic> json) =>
    SeriesSchedule(
      time: json['time'] as String,
      days: (json['days'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$SeriesScheduleToJson(SeriesSchedule instance) =>
    <String, dynamic>{
      'time': instance.time,
      'days': instance.days,
    };
