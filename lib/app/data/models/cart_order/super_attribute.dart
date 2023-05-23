class SuperAttribute {
  late String code;
  late int value;
  late String name;
  late String label;

  SuperAttribute({
    required this.code,
    required this.value,
    required this.name,
    required this.label,
  });

  SuperAttribute.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    value = json['value'];
    name = json['name'];
    label = json['label'];
  }


}
