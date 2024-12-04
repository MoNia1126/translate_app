import '../../data/models/language_model.dart';

abstract class LanguageState {}

class LanguageInitial extends LanguageState {}

class LanguageLoading extends LanguageState {}

class LanguageLoaded extends LanguageState {

  final String translatedText;
  LanguageLoaded(this.translatedText);
}
class LanguagesLoaded extends LanguageState {
  final List<Language> languages;

  LanguagesLoaded(this.languages);

}
class LanguageError extends LanguageState {
  final String message;

  LanguageError(this.message);
}
