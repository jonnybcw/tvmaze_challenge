// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_series.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchSeries _$SearchSeriesFromJson(Map<String, dynamic> json) => SearchSeries(
      score: (json['score'] as num).toDouble(),
      show: SeriesDetails.fromJson(json['show'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchSeriesToJson(SearchSeries instance) =>
    <String, dynamic>{
      'score': instance.score,
      'show': instance.show,
    };
