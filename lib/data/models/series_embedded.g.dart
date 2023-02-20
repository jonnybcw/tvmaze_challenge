// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series_embedded.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeriesEmbedded _$SeriesEmbeddedFromJson(Map<String, dynamic> json) =>
    SeriesEmbedded(
      episodes: (json['episodes'] as List<dynamic>)
          .map((e) => SeriesEpisode.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SeriesEmbeddedToJson(SeriesEmbedded instance) =>
    <String, dynamic>{
      'episodes': instance.episodes,
    };
