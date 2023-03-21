import 'package:app_seneca_registros_bano/services/firebase_service.dart';
import 'package:app_seneca_registros_bano/utils/email_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_seneca_registros_bano/utils/models.dart';
import 'package:app_seneca_registros_bano/utils/providers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState(usuarios: []);
}

class _LoginPageState extends State<LoginPage> {
  final UsuariosProvider usuario = UsuariosProvider();
  final EmailChecker checker = EmailChecker();

  final controller = TextEditingController();
  final controller2 = TextEditingController();

  final List<Usuarios> usuarios;

  _LoginPageState({required this.usuarios});

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool loading = false;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: width,
        padding: const EdgeInsets.only(top: 120.0),
        height: height * 10.0,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromRGBO(48, 110, 190, 1),
              Color.fromRGBO(48, 90, 190, 1),
              Color.fromRGBO(48, 70, 190, 1),
              Color.fromRGBO(48, 50, 190, 1)
            ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _titulo(),
            //SizedBox(width: width * 0.85, child: _textFieldUsuario()),
            //const SizedBox(height: 25.0),
            //SizedBox(width: width * 0.85, child: _textFieldPassword()),
            //const SizedBox(height: 25.0),
            //SizedBox(width: width * 0.85, height: 40.0, child: _botonEntrar()),
            //const SizedBox(height: 25.0),
            SizedBox(
                width: width * 0.85,
                height: 40.0,
                child: _botonEntrarGoogle(loading)),
            const SizedBox(height: 25.0),
            //_recordarpassword(),
            //const SizedBox(height: 25.0),
            _imagen(),
            _version(height),
          ],
        ),
      ),
    );
  }

  Widget _titulo() {
    return const Text(
      'iSéneca',
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 68.0, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }

  Widget _textFieldUsuario() {
    return TextField(
        controller: controller,
        decoration: const InputDecoration(
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            labelText: 'Usuario',
            labelStyle: TextStyle(color: Colors.white)));
  }

  Widget _textFieldPassword() {
    return TextField(
      controller: controller2,
      obscureText: true,
      decoration: const InputDecoration(
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        labelText: 'Contraseña',
        labelStyle: TextStyle(color: Colors.white),
        suffixIcon: IconButton(
          icon: Icon(Icons.remove_red_eye, color: Colors.white),
          onPressed: null,
        ),
      ),
    );
  }

  Widget _botonEntrar() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        //disabledColor: Colors.grey,
        //disabledTextColor: Colors.black,
        padding: const EdgeInsets.all(10.0),
        //splashColor: Colors.blueAccent,
      ),
      onPressed: () {
        comprobarUsuario(context);
        //Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
      },
      child: const Text(
        "Entrar",
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }

  Widget _botonEntrarGoogle(bool loading) {
    return ElevatedButton.icon(
      onPressed: () async {
        setState(() {
          loading = true;
        });
        FirebaseService service = FirebaseService();
        try {
          await service.signInwithGoogle();
          User? user = FirebaseAuth.instance.currentUser;
          if (await checker.compruebaEmail(user) == true) {
            Navigator.pushNamed(
                context, 'homepage');
          } else {
            await service.signOutFromGoogle();
            showMessageLogin();
          }
        } catch (e) {
          if (e is FirebaseAuthException) {
            showMessage(e.message!);
          }
        }
        setState(() {
          loading = false;
        });
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.blue,
          padding: const EdgeInsets.all(10.0)),
      icon: const FaIcon(FontAwesomeIcons.google),
      label: const Text(
        "Entrar",
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }

  Widget _recordarpassword() {
    return const Text(
      'No recuerdo mi contraseña',
      style: TextStyle(
        fontSize: 20.0,
        color: Colors.white,
        decoration: TextDecoration.underline,
      ),
    );
  }

  Widget _imagen() {
    return Image.asset(
      'assets/logo-junta.png',
      width: 130.0,
      height: 180.0,
    );
  }

  Widget _version(height) {
    return Container(
      height: 16.0,
      margin: const EdgeInsets.only(left: 265.0),
      child: const Text('v11.3.0',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 17.0)),
    );
  }

  void comprobarUsuario(BuildContext context) async {
    final usuarios = await usuario.getDatos(); //usuariosProvider lo hemos
    //definido como atributo.
    for (var user in usuarios) {
      if (user.usuario == controller.text &&
          user.password == controller2.text) {
        Navigator.pushNamed(context, 'homepage');
      }

      //Navigator.push(
      //    context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  void showMessageLogin() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text(
                "La cuenta de Google que ha iniciado sesión no pertenece a nuestra hoja de datos"),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'))
            ],
          );
        });
  }

  void showMessage(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text("Se ha producido un error: $message"),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'))
            ],
          );
        });
  }
}
