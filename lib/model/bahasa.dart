class Bahasa {
  int? id;
  String? originalLanguage;
  String? translatedLanguage;
  String? translatorName;

  // Constructor
  Bahasa(
      {this.id,
      this.originalLanguage,
      this.translatedLanguage,
      this.translatorName});

  // Factory method to create a Bahasa object from JSON
  factory Bahasa.fromJson(Map<String, dynamic> obj) {
    return Bahasa(
      id: obj['id'] is String ? int.tryParse(obj['id']) : obj['id'],
      originalLanguage: obj['original_language'],
      translatedLanguage: obj['translated_language'],
      translatorName: obj['translator_name'],
    );
  }
}
