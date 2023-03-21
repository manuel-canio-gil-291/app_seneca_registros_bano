import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
      clientId:
          '224306810903-5ukq0m9prd8abuu6p2ra9frt7btdvjm4.apps.googleusercontent.com');

  signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      rethrow;
    }
  }

  signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
