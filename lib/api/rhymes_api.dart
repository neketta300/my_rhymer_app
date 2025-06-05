import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_rhymer/api/models/rhymes.dart';
import 'package:retrofit/retrofit.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'rhymes_api.g.dart';

@RestApi(baseUrl: '')
abstract class RhymeApiClient {
  factory RhymeApiClient(Dio dio, {String baseUrl}) = _RhymeApiClient;

  factory RhymeApiClient.create({
    required String? apiUrl,
    required BuildContext context,
  }) {
    final dio = Dio();
    // Добавление логгирования
    dio.interceptors.add(
      TalkerDioLogger(
        talker: context.read<Talker>(),
        settings: const TalkerDioLoggerSettings(printRequestData: false),
      ),
    );
    if (apiUrl != null) {
      return RhymeApiClient(dio, baseUrl: apiUrl);
    }
    return RhymeApiClient(dio);
  }

  // запроc с квери параметром
  @GET('/rhymes')
  Future<Rhymes> getRhymesList(@Query('word') String word);
}
