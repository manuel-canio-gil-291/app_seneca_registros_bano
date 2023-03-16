import 'dart:convert';
import 'package:app_seneca_registros_bano/utils/models.dart';
import 'package:http/http.dart' as http;

class InformeFiltradoProvider {
  final String _spreadsheetId = '1FZbxKiAxsl4TrMr6Z4ouCmRIJVZpf-FPQT1JBbOZEnw';
  final String _url = 'script.google.com';
  final String _sheet = 'registros';
  //Futuro para obtener la lista con los registros de los alumnos que han ido al baño
  Future<List<Registro>> getRegistrosFiltrados(
      fechaInicio, fechaFin, nombre) async {
    final url = Uri.https(
        _url,
        'macros/s/AKfycbx7DJkQ5P-pFBsdR5NaNmo4TCJxN8n-n0TnW6LENOJmF_6e1gO9wYOzKiaqfHtgV-C-6g/exec',
        {
          //Libro y hoja
          'spreadsheetId': _spreadsheetId,
          'sheet': _sheet,
          //Filtro por fecha
          'fechaInicio': fechaInicio,
          'fechaFin': fechaFin,
          //Filtro por alumno
          'alumno': nombre
        });

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final registro = Informes.fromJsonList(decodeData);

    return registro.items;
  }
}
