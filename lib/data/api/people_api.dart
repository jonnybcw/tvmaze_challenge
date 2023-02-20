import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tvmaze_challenge/data/api/api_constants.dart';
import 'package:tvmaze_challenge/data/models/cast_credits.dart';
import 'package:tvmaze_challenge/data/models/search_person.dart';

class PeopleApi {
  static Future<List<SearchPerson>> searchPeople({
    required Dio client,
    required String query,
  }) async {
    try {
      final Response response =
          await client.get(ApiConstants.peopleSearch(query));
      List<SearchPerson> people = [];
      for (Map<String, dynamic> show in response.data) {
        people.add(SearchPerson.fromJson(show));
      }
      return people;
    } catch (error, stacktrace) {
      log('$error', name: 'searchPeople', stackTrace: stacktrace, error: error);
      rethrow;
    }
  }

  static Future<List<CastCredits>> getPersonCastCredits({
    required Dio client,
    required int personId,
  }) async {
    try {
      final Response response =
          await client.get(ApiConstants.castCredits(personId));
      List<CastCredits> castCredits = [];
      for (Map<String, dynamic> item in response.data) {
        castCredits.add(CastCredits.fromJson(item));
      }
      return castCredits;
    } catch (error, stacktrace) {
      log('$error',
          name: 'getPersonCastCredits', stackTrace: stacktrace, error: error);
      rethrow;
    }
  }
}
