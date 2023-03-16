// To parse this JSON data, do
//
//     final personal = personalFromJson(jsonString);
import 'dart:convert';

List<Personal> personalFromJson(String str) =>
    List<Personal>.from(json.decode(str).map((x) => Personal.fromJson(x)));

String personalToJson(List<Personal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Personal {
  Personal({
    required this.id,
    required this.usuario,
    required this.clave,
    required this.profesorA,
    required this.mail,
    required this.telefono,
    required this.dni,
  });

  String id;
  String usuario;
  String clave;
  String profesorA;
  String mail;
  String telefono;
  String dni;

  factory Personal.fromJson(Map<String, dynamic> json) => Personal(
        id: json["id"],
        usuario: json["usuario"],
        clave: json["clave"],
        profesorA: json["profesorA"],
        mail: json["mail"],
        telefono: json["telefono"],
        dni: json["dni"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "usuario": usuario,
        "clave": clave,
        "profesorA": profesorA,
        "mail": mail,
        "telefono": telefono,
        "dni": dni,
      };
}

class Persona {
  List<Personal> items = [];

  Persona();

  Persona.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final p = Personal.fromJson(item);
      items.add(p);
    }
  }
}
