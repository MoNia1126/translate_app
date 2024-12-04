import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/cubit/languageCubit/language_state.dart';
import 'package:task2/data/models/translate_requset_model.dart';
import 'package:task2/data/repository/language_repo.dart';

// class LanguageCubit extends Cubit<LanguageState> {
//   final Dio _dio = Dio();
//
//   LanguageCubit() : super(LanguageInitial());
//
//   Future<void> translateText(String text) async {
//     emit(LanguageLoading());
//
//     try {
//       final request = TranslationRequest(
//         q: text,
//         source: 'en',
//         target: 'ar',
//       );
//
//       final response = await _dio.post(
//         'https://libretranslate.de/translate',
//         options: Options(contentType: 'application/json'),
//         data: request.toJson(),
//       );
//
//       if (response.statusCode == 200) {
//         final translatedResponse = TranslationResponse.fromJson(response.data);
//         emit(LanguageLoaded(translatedResponse.translatedText));
//       } else {
//         emit(LanguageError('Failed to translate text'));
//       }
//     } catch (e) {
//       emit(LanguageError('An error occurred: $e'));
//     }
//   }
// }
// class LanguageCubit extends Cubit<LanguageState> {
//   final Dio _dio = Dio();
//   String _targetLanguage = 'ar'; // Default target language is Arabic
//
//   LanguageCubit() : super(LanguageInitial());
//
//   void changeTargetLanguage(String newLanguage) {
//     _targetLanguage = newLanguage;
//     emit(LanguageInitial()); // Optional: Reset state on language change
//   }
//
//   Future<void> translateText(String text) async {
//     emit(LanguageLoading());
//
//     try {
//       final request = TranslationRequest(
//         q: text,
//         source: 'en',
//         target: _targetLanguage,
//       );
//
//       final response = await _dio.post(
//         'https://libretranslate.de/translate',
//         options: Options(contentType: 'application/json'),
//         data: request.toJson(),
//       );
//
//       if (response.statusCode == 200) {
//         final translatedResponse = TranslationResponse.fromJson(response.data);
//         emit(LanguageLoaded(translatedResponse.translatedText));
//       } else {
//         emit(LanguageError('Failed to translate text'));
//       }
//     } catch (e) {
//       emit(LanguageError('An error occurred: $e'));
//     }
//   }
// }

class LanguageCubit extends Cubit<LanguageState> {
    final LanguageRepository languageRepository = LanguageRepository();


  // final LanguageRepository _languageRepository;
  String _targetLanguage = 'ar';

  LanguageCubit() : super(LanguageInitial());

  void changeTargetLanguage(String newLanguage) {
    _targetLanguage = newLanguage;
    emit(LanguageInitial()); // Optional: Reset state on language change
  }

  Future<void> translateText(String text) async {
    emit(LanguageLoading());

    try {
      final request = TranslationRequest(
        q: text,
        source: 'en',
        target: _targetLanguage,
      );

      final translatedResponse = await languageRepository.translateText(request);
      emit(LanguageLoaded(translatedResponse.translatedText));
    } catch (e) {
      emit(LanguageError('An error occurred: $e'));
    }
  }

  Future<void> fetchLanguages() async {
    emit(LanguageLoading());

    try {
      final languages = await languageRepository.fetchLanguages();
      // Assuming we need to store these or make them available for a dropdown or similar
      emit(LanguagesLoaded(languages));
    } catch (e) {
      emit(LanguageError('Failed to load languages: $e'));
    }
  }
}

