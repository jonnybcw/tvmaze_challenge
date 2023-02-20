// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchPerson _$SearchPersonFromJson(Map<String, dynamic> json) => SearchPerson(
      score: (json['score'] as num).toDouble(),
      person: Person.fromJson(json['person'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchPersonToJson(SearchPerson instance) =>
    <String, dynamic>{
      'score': instance.score,
      'person': instance.person,
    };
