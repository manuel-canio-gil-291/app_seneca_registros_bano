// To parse this JSON data, do
//
//     final registro = registroFromJson(jsonString);
import 'dart:convert';
import 'dart:collection';

List<Registro> registroFromJson(String str) =>
    List<Registro>.from(json.decode(str).map((x) => Registro.fromJson(x)));

String registroToJson(List<Registro> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Informes {
  //Lista con todos los registros
  List<Registro> items = [];
  //Lista de cadenas para filtrar y no mostrar valores repetidos
  List<String> lista = [];
  //Lista para eliminar los valores repetidos
  List<String> resultunico = [];
  Informes();
  //Informes lista
  Informes.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    //Proceso todos los registros
    for (var item in jsonList) {
      final registro = Registro.fromJson(item);
      items.add(registro);
      //Para cada nombre que recojo cuenta las veces que sale
      var contador = 0;
      for (var vuelta in jsonList) {
        final linea = Registro.fromJson(vuelta);
        if (registro.alumno == linea.alumno) {
          contador++;
        }
      }
      //Añado todos los elementos los campos que necesitaremos mostrar
      lista.add('${contador / 2};${registro.alumno};${registro.curso}');
    }

    //Eliminamos los valores repetidos
    resultunico = LinkedHashSet<String>.from(lista).toList();
    //Ordenar de mas a menos salidas
    resultunico.sort((b, a) => a.compareTo(b));
  }
}

class Registro {
  Registro({
    required this.alumno,
    required this.curso,
    required this.diaHora,
    required this.accion,
  });

  String alumno;
  String curso;
  String diaHora;
  String accion;

  factory Registro.fromJson(Map<String, dynamic> json) => Registro(
        alumno: json["Alumno"],
        curso: json["Curso"],
        diaHora: json["Dia/Hora"],
        accion: json["Accion"],
      );

  Map<String, dynamic> toJson() => {
        "Alumno": alumno,
        "Curso": curso,
        "Dia/Hora": diaHora,
        "Accion": accion,
      };
}
