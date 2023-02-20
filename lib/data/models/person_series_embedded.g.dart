// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_series_embedded.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonSeriesEmbedded _$PersonSeriesEmbeddedFromJson(
        Map<String, dynamic> json) =>
    PersonSeriesEmbedded(
      show: SeriesDetails.fromJson(json['show'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PersonSeriesEmbeddedToJson(
        PersonSeriesEmbedded instance) =>
    <String, dynamic>{
      'show': instance.show,
    };
