class StateModel {
  late int id;
  late String countryCode;
  late String code;
  late String defaultName;
  late int countryId;
  late List<StateTranslations> translations;

  StateModel({
    required this.id,
    required this.countryCode,
    required this.code,
    required this.defaultName,
    required this.countryId,
    required this.translations,
  });

  StateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryCode = json['country_code'];
    code = json['code'];
    defaultName = json['default_name'];
    countryId = json['country_id'];
    if (json['translations'] != null) {
      translations = <StateTranslations>[];
      json['translations'].forEach((v) {
        translations.add(StateTranslations.fromJson(v));
      });
    }
  }

  static List<StateModel> listFromJson(list) => List<StateModel>.from(list.map((x) => StateModel.fromJson(x)));
}

class StateTranslations {
  late int id;
  late String locale;
  late String defaultName;
  late int countryStateId;

  StateTranslations({
    required this.id,
    required this.locale,
    required this.defaultName,
    required this.countryStateId,
  });

  StateTranslations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    locale = json['locale'];
    defaultName = json['default_name'];
    countryStateId = json['country_state_id'];
  }
}
