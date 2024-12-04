import 'package:task2/data/models/language_model.dart';
import 'package:task2/data/models/translate_requset_model.dart';
import 'package:task2/data/models/translate_response_model.dart';
import 'package:task2/data/services/api_service_get.dart';

class LanguageRepository {
  // final ApiService _apiService;
  final ApiService _apiService = ApiService();

  LanguageRepository();

  Future<List<Language>> fetchLanguages() async {
    return await _apiService.getLanguages();
  }

  Future<TranslationResponse> translateText(TranslationRequest request) async {
    return await _apiService.translateText(request);
  }
}
