import 'dart:convert';

Pharmacy pharmacyFromMap(String str) => Pharmacy.fromMap(json.decode(str));

String pharmacyToMap(Pharmacy data) => json.encode(data.toMap());

class Pharmacy {
  Pharmacy({
    this.id,
    this.name,
    this.location,
  });

  int id;
  String name;
  String location;

  Pharmacy copyWith({
    int id,
    String name,
    String location,
  }) =>
      Pharmacy(
        id: id ?? this.id,
        name: name ?? this.name,
        location: location ?? this.location,
      );

  factory Pharmacy.fromMap(Map<String, dynamic> json) => Pharmacy(
        id: json["id"],
        name: json["name"],
        location: json["location"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "location": location,
      };

  @override
  String toString() {
    return 'ID: $id - NAME: $name';
  }
}
