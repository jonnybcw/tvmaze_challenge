// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SeriesDetailsAdapter extends TypeAdapter<SeriesDetails> {
  @override
  final int typeId = 1;

  @override
  SeriesDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SeriesDetails(
      id: fields[0] as int,
      name: fields[1] as String,
      genres: (fields[2] as List).cast<String>(),
      image: fields[3] as SeriesImage?,
      summary: fields[4] as String?,
      schedule: fields[5] as SeriesSchedule,
    );
  }

  @override
  void write(BinaryWriter writer, SeriesDetails obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.genres)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.summary)
      ..writeByte(5)
      ..write(obj.schedule);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeriesDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeriesDetails _$SeriesDetailsFromJson(Map<String, dynamic> json) =>
    SeriesDetails(
      id: json['id'] as int,
      name: json['name'] as String,
      genres:
          (json['genres'] as List<dynamic>).map((e) => e as String).toList(),
      image: json['image'] == null
          ? null
          : SeriesImage.fromJson(json['image'] as Map<String, dynamic>),
      summary: json['summary'] as String?,
      schedule:
          SeriesSchedule.fromJson(json['schedule'] as Map<String, dynamic>),
      embedded: json['_embedded'] == null
          ? null
          : SeriesEmbedded.fromJson(json['_embedded'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SeriesDetailsToJson(SeriesDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'genres': instance.genres,
      'image': instance.image,
      'summary': instance.summary,
      'schedule': instance.schedule,
      '_embedded': instance.embedded,
    };
