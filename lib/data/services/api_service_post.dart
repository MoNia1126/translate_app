// import 'package:dio/dio.dart';
// import 'package:task2/data/models/translate_requset_model.dart';
// import 'package:task2/data/models/translate_response_model.dart';
//
// class ApiService {
//   final String baseUrl = 'https://libretranslate.com/';
//   final Dio _dio = Dio(BaseOptions(
//     baseUrl: 'https://libretranslate.com/',
//     headers: {'Content-Type': 'application/json'},
//   ));
//
//   Future<TranslationResponse> translateText(TranslationRequest request) async {
//     try {
//       final response = await _dio.post(
//         '$baseUrl/translate',
//         data: request.toJson(),
//       );
//
//       if (response.statusCode == 200) {
//         return TranslationResponse.fromJson(response.data);
//       } else {
//         throw Exception('Failed to translate text');
//       }
//     } catch (e) {
//       throw Exception('Failed to translate text: $e');
//     }
//   }
// }
