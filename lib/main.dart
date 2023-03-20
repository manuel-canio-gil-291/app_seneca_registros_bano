import 'package:app_seneca_registros_bano/firebase_options.dart';
import 'package:app_seneca_registros_bano/utils/pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
          'toilet': (BuildContext context) => const ToiletPage(),
          'calendario': (BuildContext context) => const CalendarioPage(),
          'informes': (BuildContext context) => InformesPage(),
          'informes_filtrados': (BuildContext context) =>
              InformesFiltradosPage(),
          'filtro': (BuildContext context) => const RegistrosBarraFiltro()
        });
  }
}
