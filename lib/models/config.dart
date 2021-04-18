import 'dart:convert';

Config configFromMap(String str) => Config.fromMap(json.decode(str));

String configToMap(Config data) => json.encode(data.toMap());

class Config {
  Config({
    this.id,
    this.name,
    this.value,
  });

  int id;
  String name;
  String value;

  Config copyWith({
    int id,
    String name,
    String value,
  }) =>
      Config(
        id: id ?? this.id,
        name: name ?? this.name,
        value: value ?? this.value,
      );

  factory Config.fromMap(Map<String, dynamic> json) => Config(
        id: json["id"],
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "value": value,
      };
}
