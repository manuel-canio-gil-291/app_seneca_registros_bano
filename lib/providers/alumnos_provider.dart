import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_seneca_registros_bano/utils/models.dart';

class AlumnosProvider {
  final String _spreadsheetId = '1FZbxKiAxsl4TrMr6Z4ouCmRIJVZpf-FPQT1JBbOZEnw';
  final String _url = 'script.google.com';
  final String _sheet = 'alumnos';

  Future<List<Alumno>> getAlumnos(curso) async {
    final url = Uri.https(
        _url,
        'macros/s/AKfycbwyd4nMiwTe4Yd_V2f6gKLFyaPoyKJD0DG_6vUdr2qvIy4E92yE9UQIeV0eSHOi_HC6/exec',
        {
          'spreadsheetId': _spreadsheetId,
          'sheet': _sheet,
          //Pasamos por aquí el argumento para que nos muestre la lista solo con los elementos filtrados
          'curso': curso
        });

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);

    final alumno = Alumnos.fromJsonList(decodeData);

    return alumno.items;
  }
}
