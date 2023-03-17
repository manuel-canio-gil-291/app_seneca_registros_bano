import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_seneca_registros_bano/utils/models.dart';

class CursosProvider {
  final String _spreadsheetId = '1FZbxKiAxsl4TrMr6Z4ouCmRIJVZpf-FPQT1JBbOZEnw';
  final String _url = 'script.google.com';
  final String _sheet = 'grupos';

  Future<List<Grupo>> getCursos() async {
    final url = Uri.https(
        _url,
        'macros/s/AKfycbzLH3AyGXkrxj-i5WVOyLwJcDtKXmIE4JNMq1Z8Ldkqbcg3PPePkJIWNhHTUceXgdLILw/exec',
        {'spreadsheetId': _spreadsheetId, 'sheet': _sheet});

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);

    final grupo = Grupos.fromJsonList(decodeData);

    return grupo.items;
  }
}
