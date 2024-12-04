class Language{
  final String code;
  final String name;
  final List<String> targets;

  Language({required this.name, required this.code, required this.targets});

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      code: json['code'] as String,
      name: json['name'] as String,
      targets: List<String>.from(json['targets'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'targets': targets,
    };
  }
}