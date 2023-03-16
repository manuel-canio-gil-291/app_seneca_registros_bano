import 'dart:convert';
import 'package:app_seneca_registros_bano/utils/models.dart';
import 'package:http/http.dart' as http;

class InformeProvider {
  final String _spreadsheetId = '1FZbxKiAxsl4TrMr6Z4ouCmRIJVZpf-FPQT1JBbOZEnw';
  final String _url = 'script.google.com';
  final String _sheet = 'registros';
  //Futuro para obtener la lista con los registros de los alumnos que han ido al baño
  Future<List<String>> getRegistros(start, end) async {
    final url = Uri.https(
        _url,
        'macros/s/AKfycbx6JRCelsrrr34mYxXIXtXpHhjkjTabKEq8IpcwmP8XseWigYsXmKxmWw-AgkTEW4XU/exec',
        {
          'spreadsheetId': _spreadsheetId,
          'sheet': _sheet,
          //Pasamos las cadenas con los días de inicio y fin del intervalo que queremos mostrar los registros
          'fechaInicio': start,
          'fechaFin': end,
        });

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);

    final registro = Informes.fromJsonList(decodeData);

    return registro.resultunico;
  }
}
