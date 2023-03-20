import 'package:app_seneca_registros_bano/utils/providers.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailChecker {
  User? user = FirebaseAuth.instance.currentUser;
  final EmailsProvider correoprovider = EmailsProvider();

  Future<bool> compruebaEmail() async {
    final correos = await correoprovider.getEmails();

    for (var correo in correos) {
      if (correo.email == user!.email) {
        return true;
      }
    }
    return false;
  }
}
