import 'package:flutter/material.dart';
import 'dart:async';
import 'package:app_seneca_registros_bano/utils/providers.dart';

class RegistrosBarraFiltro extends StatefulWidget {
  const RegistrosBarraFiltro({super.key});

  @override
  State<RegistrosBarraFiltro> createState() => _RegistrosBarraFiltroState();
}

class Debouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class _RegistrosBarraFiltroState extends State<RegistrosBarraFiltro> {
  final _debouncer = Debouncer(milliseconds: 500);
  List<String> registros = [];
  List<String> registrosFiltrados = [];

  @override
  void initState() {
    super.initState();
    InformesTotalesProvider()
        .getRegistrosTotales()
        .then((registrosFromProvider) {
      setState(() {
        registros = registrosFromProvider;
        registrosFiltrados = registros;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alumnado que ha salido al baño'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(15.0),
                hintText: 'Filtrar por nombre o por curso'),
            onChanged: (string) {
              _debouncer.run(() {
                setState(() {
                  registrosFiltrados = registros
                      .where((alumno) => (alumno
                              .toLowerCase()
                              .contains(string.toLowerCase()) ||
                          alumno.toLowerCase().contains(string.toLowerCase())))
                      .toList();
                });
              });
            },
          ),
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(10.0),
                  itemCount: registrosFiltrados.length,
                  itemBuilder: (BuildContext context, int index) {
                    //Trabajamos los datos para ver como los queremos mandar a la pantalla
                    String tocho1 = registrosFiltrados[index];
                    int divisor1 = tocho1.indexOf(' ');
                    String total = tocho1.substring(0, divisor1);
                    String tocho2 = tocho1.substring(divisor1 + 1);
                    int divisor2 = tocho2.indexOf(';');
                    String nombreAlumno = tocho2.substring(0, divisor2);
                    String cursoAlumno = tocho2.substring(divisor2 + 3);

                    return ListTile(
                      title: Text(
                          '$total - Alumno:$nombreAlumno - Curso:$cursoAlumno'),
                      onTap: () {
                        Navigator.pushNamed(context, 'filtroAlumno',
                            arguments: '$nombreAlumno.$cursoAlumno');
                      },
                    );
                  }))
        ],
      ),
    );
  }
}
