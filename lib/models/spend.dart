import 'dart:convert';

Spend spendFromMap(String str) => Spend.fromMap(json.decode(str));
String spendToMap(Spend data) => json.encode(data.toMap());

class Spend {
  Spend({
    this.id,
    this.amount,
    this.description,
    this.createdAt,
    this.userId,
    this.pharmacyId,
  });

  int id;
  num amount;
  String description;
  String createdAt;
  int userId;
  int pharmacyId;

  Spend copyWith({
    int id,
    num amount,
    String description,
    String createdAt,
    int userId,
    int pharmacyId,
  }) =>
      Spend(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
        userId: userId ?? this.userId,
        pharmacyId: pharmacyId ?? this.pharmacyId,
      );

  factory Spend.fromMap(Map<String, dynamic> json) => Spend(
        id: json["id"],
        amount: json["amount"].toDouble(),
        description: json["description"],
        createdAt: json["created_at"],
        userId: json["user_id"],
        pharmacyId: json["pharmacy_id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "amount": amount,
        "description": description,
        "created_at": createdAt,
        "user_id": userId,
        "pharmacy_id": pharmacyId,
      };

  @override
  String toString() {
    return 'ID: $id - DESCRIPTION: $description';
  }
}
