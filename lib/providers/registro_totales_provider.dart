import 'dart:convert';
import 'package:app_seneca_registros_bano/utils/models.dart';
import 'package:http/http.dart' as http;

class InformesTotalesProvider {
  final String _spreadsheetId = '1FZbxKiAxsl4TrMr6Z4ouCmRIJVZpf-FPQT1JBbOZEnw';
  final String _url = 'script.google.com';
  final String _sheet = 'registros';
  //Futuro para obtener la lista con los registros de los alumnos que han ido al baño
  Future<List<String>> getRegistrosTotales() async {
    final url = Uri.https(
        _url,
        'macros/s/AKfycbz2LxPqnd2T48poC_I_benIfd76DJlrP-kqxpnJdd5YGYNAoizRZ3Mr3vL7yi7AjM4L/exec',
        {'spreadsheetId': _spreadsheetId, 'sheet': _sheet});

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);

    final registro = Informes.fromJsonList(decodeData);

    print(registro.lista);
    print('-----------------------');
    print(registro.resultunico);
    print('-----------------------');

    return registro.resultunico;
  }
}
