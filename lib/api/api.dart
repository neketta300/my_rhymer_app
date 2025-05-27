import 'dart:async';

import 'package:dio/dio.dart';
import 'package:my_rhymer/api/models/rhymes.dart';
import 'package:retrofit/retrofit.dart';

part 'api.g.dart';

@RestApi(baseUrl: '')
abstract class RhymeApiClient {
  factory RhymeApiClient(Dio dio, {String baseUrl}) = _RhymeApiClient;

  factory RhymeApiClient.create({required String? apiUrl}) {
    final dio = Dio();
    if (apiUrl != null) {
      return RhymeApiClient(dio, baseUrl: apiUrl);
    }
    return RhymeApiClient(dio);
  }

  // запроc с квери параметром
  @GET('/rhymes')
  Future<Rhymes> getRhymesList(@Query('word') String word);
}
