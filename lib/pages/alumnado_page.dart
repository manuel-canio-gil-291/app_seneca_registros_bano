import 'package:flutter/material.dart';
import 'package:app_seneca_registros_bano/utils/models.dart';
import 'package:app_seneca_registros_bano/utils/providers.dart';

class AlumnosCentro extends StatelessWidget {
  final AlumnosProvider alumno = AlumnosProvider();

  AlumnosCentro({super.key});

  @override
  Widget build(BuildContext context) {
    //Cogemos el curso que hemos pasado de la pagina anterior
    final argumento = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Alumnado: $argumento'),
      ),
      body: FutureBuilder(
          future: alumno.getAlumnos(argumento),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              //Aqui ya viene la lista completa
              return ListaAlumnos(lisAlum: snapshot.data);
            }
          }),
    );
  }
}

// Crear la lista nueva
class ListaAlumnos extends StatelessWidget {
  final List<Alumno> lisAlum;
  // Lista entera
  const ListaAlumnos({super.key, required this.lisAlum});
  @override
  Widget build(BuildContext context) {
    // Cogemos el curso que hemos pasado
    return ListView.builder(
      itemCount: lisAlum.length,
      itemBuilder: (context, int index) {
        final alumno = lisAlum[index];
        return ListTile(
          title: Text(alumno.alumnoA),
          subtitle: Text(alumno.unidad),
          onTap: () {
            Navigator.pushNamed(context, 'toilet',
                arguments: ('${alumno.alumnoA}+${alumno.unidad}'));
          },
        );
      },
    );
  }
}
