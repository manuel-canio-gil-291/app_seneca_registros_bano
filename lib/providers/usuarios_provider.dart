import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_seneca_registros_bano/utils/models.dart';

class UsuariosProvider {
  final String _spreadsheetId = '1FZbxKiAxsl4TrMr6Z4ouCmRIJVZpf-FPQT1JBbOZEnw';
  final String _url = 'script.google.com';
  final String _sheet = 'usuarios';

  Future<List<Usuarios>> getDatos() async {
    final url = Uri.https(
        _url,
        'macros/s/AKfycbz2LxPqnd2T48poC_I_benIfd76DJlrP-kqxpnJdd5YGYNAoizRZ3Mr3vL7yi7AjM4L/exec',
        {'spreadsheetId': _spreadsheetId, 'sheet': _sheet});

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);

    print(decodeData);

    final user = Usuario.fromJsonList(decodeData);

    return user.items;
  }
}
