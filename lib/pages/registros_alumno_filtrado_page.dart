import 'package:flutter/material.dart';
import 'package:app_seneca_registros_bano/utils/models.dart';
import 'package:app_seneca_registros_bano/utils/providers.dart';

class InformesFiltradosPage extends StatelessWidget {
  final InformeFiltradoProvider registro = InformeFiltradoProvider();

  InformesFiltradosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final argumento = ModalRoute.of(context)!.settings.arguments.toString();
    int divisor = argumento.indexOf('.');
    String nombre = argumento.substring(0, divisor);
    String argumento2 = argumento.substring(divisor + 1);
    int divisor2 = argumento2.indexOf('.');
    String curso = argumento2.substring(0, divisor2);
    String argumento3 = argumento2.substring(divisor2 + 1);
    int divisor3 = argumento3.indexOf('.');
    String fechaInicio = argumento3.substring(0, divisor3);
    String fechaFin = argumento3.substring(divisor3 + 1);

    return Scaffold(
      appBar: AppBar(title: Text('Alumno: $nombre Curso: $curso')),
      body: FutureBuilder(
          // Le pasamos los parámetros para filtrar los registros de nuestra hoja de cálculo
          future: registro.getRegistrosFiltrados(fechaInicio, fechaFin, nombre),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return _ListaRegistrosFiltrados(
                  lisRegistros: snapshot.data, nombreAlumno: nombre);
            }
          }),
    );
  }
}

class _ListaRegistrosFiltrados extends StatelessWidget {
  final List<Registro> lisRegistros;
  final String nombreAlumno;

  const _ListaRegistrosFiltrados(
      {required this.lisRegistros, required this.nombreAlumno});

  @override
  Widget build(BuildContext context) {
    int veces = 0;
    return ListView.builder(
        itemCount: lisRegistros.length,
        itemBuilder: (BuildContext context, int index) {
          final registro = lisRegistros[index];
          if (registro.accion == 'Salida') {
            veces++;
          }
          return ListTile(
            title: Text(
                'Dia/Hora: ${registro.diaHora}, Accion: ${registro.accion}'),
            onTap: () {
              mostrarDialogoNumeroVeces(context, veces, nombreAlumno, lisRegistros[0]);
            },
          );
        });
  }

  mostrarDialogoNumeroVeces(
      BuildContext context, int veces, String nombreAlumno, Registro registroInicio) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Numero de veces'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('El alumno $nombreAlumno ha ido al baño $veces veces.'),
                  Text('Período desde el: ${registroInicio.diaHora}')
                ],
              ),
            ),
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
