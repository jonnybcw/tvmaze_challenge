import 'package:dio/dio.dart';
import 'package:tvmaze_challenge/data/api/api_constants.dart';
import 'package:tvmaze_challenge/data/api/people_api.dart';
import 'package:tvmaze_challenge/data/models/cast_credits.dart';
import 'package:tvmaze_challenge/data/models/search_person.dart';

class PeopleRepository {
  final Dio _client = ApiConstants.getDioClient();

  Future<List<SearchPerson>> searchPeople({
    required String query,
  }) async {
    List<SearchPerson> people = await PeopleApi.searchPeople(
      client: _client,
      query: query,
    );
    return people;
  }

  Future<List<CastCredits>> getPersonCastCredits({
    required int personId,
  }) async {
    List<CastCredits> castCredits = await PeopleApi.getPersonCastCredits(
      client: _client,
      personId: personId,
    );
    return castCredits;
  }
}
