// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

List<Usuarios> usuarioFromJson(String str) =>
    List<Usuarios>.from(json.decode(str).map((x) => Usuarios.fromJson(x)));

String usuarioToJson(List<Usuarios> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Usuarios {
  Usuarios({
    required this.id,
    required this.usuario,
    required this.password,
  });

  String id;
  String usuario;
  String password;

  factory Usuarios.fromJson(Map<String, dynamic> json) => Usuarios(
        id: json["id"],
        usuario: json["usuario"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "usuario": usuario,
        "password": password,
      };
}

class Usuario {
  List<Usuarios> items = [];

  Usuario();

  Usuario.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final usuario = Usuarios.fromJson(item);
      items.add(usuario);
    }
  }
}
