// import 'package:dio/dio.dart';
// import '../models/language_model.dart';
//
// class ApiService {
//   final String baseUrl = 'https://libretranslate.com/';
//   final Dio _dio = Dio(
//       BaseOptions(
//     baseUrl: 'https://libretranslate.com/',
//     headers: {'Content-Type': 'application/json'},
//   ));
//
//   Future<List<Language>> getLanguages() async {
//     try {
//       final response = await _dio.get('$baseUrl/languages');
//
//       if (response.statusCode == 200) {
//         final List<dynamic> data = response.data;
//         return data.map((json) => Language.fromJson(json as Map<String, dynamic>)).toList();
//       } else {
//         throw Exception('Failed to load languages');
//       }
//     } catch (e) {
//       throw Exception('Failed to load languages: $e');
//     }
//   }
// }

import 'package:dio/dio.dart';
import 'package:task2/data/models/language_model.dart';
import 'package:task2/data/models/translate_requset_model.dart';
import 'package:task2/data/models/translate_response_model.dart';

class ApiService {
  final Dio _dio;

  ApiService()
      : _dio = Dio(BaseOptions(
    baseUrl: 'https://libretranslate.com/',
    headers: {'Content-Type': 'application/json'},
  ));

  Future<List<Language>> getLanguages() async {
    try {
      final response = await _dio.get('/languages');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Language.fromJson(json as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Failed to load languages');
      }
    } catch (e) {
      throw Exception('Failed to load languages: $e');
    }
  }

  Future<TranslationResponse> translateText(TranslationRequest request) async {
    try {
      final response = await _dio.post(
        '/translate',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        return TranslationResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to translate text');
      }
    } catch (e) {
      throw Exception('Failed to translate text: $e');
    }
  }
}
