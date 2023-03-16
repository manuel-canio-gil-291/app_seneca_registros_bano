import 'package:app_seneca_registros_bano/pages/alumnado_page.dart';
import 'package:app_seneca_registros_bano/pages/calendario_page.dart';
import 'package:app_seneca_registros_bano/pages/cursos_page.dart';
import 'package:app_seneca_registros_bano/pages/home_page.dart';
import 'package:app_seneca_registros_bano/pages/login_page.dart';
import 'package:app_seneca_registros_bano/pages/registros_barra_filtro.dart';
import 'package:app_seneca_registros_bano/pages/toilet_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App Séneca',
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => const LoginPage(),
          'homepage': (BuildContext context) => const HomePage(),
          'cursos': (BuildContext context) => CursosPage(),
          'alumnos': (BuildContext context) => AlumnosCentro(),
          'calendario': (BuildContext context) => const CalendarioPage(),
          'filtro': (BuildContext context) => const RegistrosBarraFiltro(),
          'toilet': (BuildContext context) => const ToiletPage()
        });
  }
}
