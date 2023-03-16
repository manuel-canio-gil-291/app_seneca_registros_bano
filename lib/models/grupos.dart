// To parse this JSON data, do
//
//     final grupos = gruposFromJson(jsonString);
import 'dart:convert';

List<Grupo> gruposFromJson(String str) =>
    List<Grupo>.from(json.decode(str).map((x) => Grupo.fromJson(x)));

String gruposToJson(List<Grupo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Grupo {
  Grupo({
    required this.cursos,
  });

  String cursos;

  factory Grupo.fromJson(Map<String, dynamic> json) => Grupo(
        cursos: json["Cursos"],
      );

  Map<String, dynamic> toJson() => {
        "Cursos": cursos,
      };
}

class Grupos {
  List<Grupo> items = [];

  Grupos();

  Grupos.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final grupo = Grupo.fromJson(item);
      items.add(grupo);
    }
  }
}
