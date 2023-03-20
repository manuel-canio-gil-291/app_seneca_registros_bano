// To parse this JSON data, do
//
//     final email = emailFromJson(jsonString);
import 'dart:convert';

List<Email> emailFromJson(String str) =>
    List<Email>.from(json.decode(str).map((x) => Email.fromJson(x)));

String emailToJson(List<Email> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Email {
  Email({
    required this.id,
    required this.email,
  });

  String id;
  String email;

  factory Email.fromJson(Map<String, dynamic> json) => Email(
        id: json["id"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
      };
}

class Emails {
  List<Email> items = [];

  Emails();

  Emails.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final email = Email.fromJson(item);
      items.add(email);
    }
  }
}
