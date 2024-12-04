class TranslationRequest {
  final String q;
  final String source;
  final String target;

  TranslationRequest({
    required this.q,
    required this.source,
    required this.target,
  });

  Map<String, dynamic> toJson() {
    return {
      'q': q,
      'source': source,
      'target': target,
    };
  }

  factory TranslationRequest.fromJson(Map<String, dynamic> json) {
    return TranslationRequest(
      q: json['q'] as String,
      source: json['source'] as String,
      target: json['target'] as String,
    );
  }
}
