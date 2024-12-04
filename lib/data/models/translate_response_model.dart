class TranslationResponse {
  final String translatedText;

  TranslationResponse({required this.translatedText});

  Map<String, dynamic> toJson() {
    return {
      'translatedText': translatedText,
    };
  }

  factory TranslationResponse.fromJson(Map<String, dynamic> json) {
    return TranslationResponse(
      translatedText: json['translatedText'] as String,
    );
  }
}
