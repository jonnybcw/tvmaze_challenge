// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series_image.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SeriesImageAdapter extends TypeAdapter<SeriesImage> {
  @override
  final int typeId = 2;

  @override
  SeriesImage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SeriesImage(
      medium: fields[0] as String,
      original: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SeriesImage obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.medium)
      ..writeByte(1)
      ..write(obj.original);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeriesImageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeriesImage _$SeriesImageFromJson(Map<String, dynamic> json) => SeriesImage(
      medium: json['medium'] as String,
      original: json['original'] as String,
    );

Map<String, dynamic> _$SeriesImageToJson(SeriesImage instance) =>
    <String, dynamic>{
      'medium': instance.medium,
      'original': instance.original,
    };
