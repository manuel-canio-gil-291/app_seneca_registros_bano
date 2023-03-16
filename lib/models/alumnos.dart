// To parse this JSON data, do
//
//     final alumno = alumnoFromJson(jsonString);

import 'dart:convert';

List<Alumno> alumnoFromJson(String str) =>
    List<Alumno>.from(json.decode(str).map((x) => Alumno.fromJson(x)));

String alumnoToJson(List<Alumno> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Alumno {
  Alumno({
    required this.alumnoA,
    required this.unidad,
  });

  String alumnoA;
  String unidad;

  factory Alumno.fromJson(Map<String, dynamic> json) => Alumno(
        alumnoA: json["Alumno/a"],
        unidad: json["Unidad"],
      );

  Map<String, dynamic> toJson() => {
        "Alumno/a": alumnoA,
        "Unidad": unidad,
      };
}

class Alumnos {
  List<Alumno> items = [];

  Alumnos();

  Alumnos.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final alumno = Alumno.fromJson(item);
      items.add(alumno);
    }
  }
}
