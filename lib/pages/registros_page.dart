import 'package:flutter/material.dart';
import 'package:app_seneca_registros_bano/utils/providers.dart';

class InformesPage extends StatelessWidget {
  final InformeProvider registro = InformeProvider();

  InformesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final argumentos = ModalRoute.of(context)!.settings.arguments.toString();
    int separador = argumentos.indexOf(';');
    String fechaInicio = argumentos.substring(0, separador);
    String fechaFin = argumentos.substring(separador + 1);

    return Scaffold(
      appBar: AppBar(
        title: Text('Periodo: $fechaInicio ---- $fechaFin'),
      ),
      body: FutureBuilder(
        //Le pasamos los parámetros para filtrar los registros de nuestra hoja de cálculo
        future: registro.getRegistros(fechaInicio, fechaFin),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return _ListaRegistros(lisRegistros: snapshot.data);
          }
        }
      ),
    );
  }
}

class _ListaRegistros extends StatelessWidget {
  final List<String> lisRegistros;

  const _ListaRegistros({required this.lisRegistros});

  @override
  Widget build(BuildContext context) {
    // Al estar en la otra clase vuelvo a coger los argumentos
    final argumentos = ModalRoute.of(context)!.settings.arguments.toString();
    int separador = argumentos.indexOf(';');
    String fechaInicio = argumentos.substring(0, separador);
    String fechaFin = argumentos.substring(separador + 1); 
    return ListView.builder(
      itemCount: lisRegistros.length,
      itemBuilder: (context, int index) {
        final registro = lisRegistros[index];
        int divisor = registro.indexOf(';');
        String total = registro.substring(0, divisor);
        String registro2 = registro.substring(divisor + 1);
        int divisor2 = registro2.indexOf(';');
        String nombreAlumno = registro2.substring(0, divisor2);
        String cursoAlumno = registro2.substring(divisor2 + 3);

        return ListTile(
          title: Text('$total - Alumno:$nombreAlumno Curso:$cursoAlumno'
          ),
          onTap: () {
            Navigator.pushNamed(context, 'informes_filtrados',
              arguments: '$nombreAlumno.$cursoAlumno.$fechaInicio.$fechaFin'
            );
          },
        );
      }
    );
  }
}