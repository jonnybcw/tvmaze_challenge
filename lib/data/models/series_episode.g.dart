// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series_episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeriesEpisode _$SeriesEpisodeFromJson(Map<String, dynamic> json) =>
    SeriesEpisode(
      id: json['id'] as int,
      name: json['name'] as String,
      season: json['season'] as int,
      number: json['number'] as int,
      image: json['image'] == null
          ? null
          : SeriesImage.fromJson(json['image'] as Map<String, dynamic>),
      summary: json['summary'] as String?,
    );

Map<String, dynamic> _$SeriesEpisodeToJson(SeriesEpisode instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'season': instance.season,
      'number': instance.number,
      'image': instance.image,
      'summary': instance.summary,
    };
