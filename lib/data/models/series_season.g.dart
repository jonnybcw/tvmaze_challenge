// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series_season.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeriesSeason _$SeriesSeasonFromJson(Map<String, dynamic> json) => SeriesSeason(
      id: json['id'] as int,
      name: json['name'] as String,
      image: SeriesImage.fromJson(json['image'] as Map<String, dynamic>),
      summary: json['summary'] as String?,
    );

Map<String, dynamic> _$SeriesSeasonToJson(SeriesSeason instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'summary': instance.summary,
    };
