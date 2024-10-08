import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixabay/config/constants/environment.dart';

final dioProvider = Provider.autoDispose<Dio>((ref) {
  return Dio(
    BaseOptions(baseUrl: "https://pixabay.com/api/", queryParameters: {
      'key': '46394117-f9ada2001ef50b8426d213b9e',
    }),
  );
});
