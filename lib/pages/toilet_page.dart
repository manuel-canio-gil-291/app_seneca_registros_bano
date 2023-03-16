import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ToiletPage extends StatefulWidget {
  const ToiletPage({super.key});

  @override
  State<ToiletPage> createState() => _ToiletPageState();
}

class _ToiletPageState extends State<ToiletPage> {
  // Inicializar botones
  final List<bool> _list = [true, false];
  // Controlamos el estado de los botones
  bool ignoring = false;
  void setIgnoring(bool newValue) {
    setState(() {
      ignoring = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Cogemos el curso que hemos pasado
    final argumentos = ModalRoute.of(context)!.settings.arguments;
    //Separamos los argumentos para trabajar con ellos
    List<String> datos = argumentos.toString().split("+");
    String nombreAlumno = datos.elementAt(0);
    String cursoAlumno = datos.elementAt(1);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(nombreAlumno),
      ),
      body: Center(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 150.0,
                height: 70.0,
                child: IgnorePointer(
                  ignoring: ignoring,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: _list[0] ? Colors.blue : Colors.grey,
                        padding: const EdgeInsets.all(16.0),
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(fontSize: 20)),
                    onPressed: () {
                      setState(() {
                        _list[0] = !_list[0];
                        _list[1] = !_list[1];
                      });
                      setIgnoring(!ignoring);
                      String salida = 'salir';
                      http.get(Uri.parse(
                          'https://script.google.com/macros/s/AKfycbwz0ySQtgFiTXLFb-PPJP-UtTd2w0gYCBysLBAOhcRfDlBlJZfIRkDMLyw6jx7DvHHT/exec?alumno=$nombreAlumno&curso=$cursoAlumno&accion=Salida'));
                      crearDialogo(nombreAlumno, salida);
                    },
                    child: const Text(
                      'Salir',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 150.0,
                height: 70.0,
                child: IgnorePointer(
                  ignoring: !ignoring,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: _list[1] ? Colors.blue : Colors.grey,
                        padding: const EdgeInsets.all(16.0),
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(fontSize: 20)),
                    onPressed: () {
                      setState(() {
                        _list[0] = !_list[1];
                        _list[0] = !_list[1];
                      });
                      setIgnoring(!ignoring);
                      String vuelta = 'volver';
                      http.get(Uri.parse(
                          'https://script.google.com/macros/s/AKfycbwz0ySQtgFiTXLFb-PPJP-UtTd2w0gYCBysLBAOhcRfDlBlJZfIRkDMLyw6jx7DvHHT/exec?alumno=$nombreAlumno&curso=$cursoAlumno&accion=Vuelta'));
                      crearDialogoVuelta(nombreAlumno, cursoAlumno, vuelta);
                    },
                    child: const Text(
                      'Volver',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //Método para crear el diálogo pasandole el nombre del alumno y la accion
  crearDialogo(String nombreAlumno, String accion) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Registro Grabado'),
            content: SingleChildScrollView(
              child: ListBody(children: <Widget>[
                Text('$nombreAlumno acaba de $accion.'),
                const Text('Se ha guardado el registro!')
              ]),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Volver'))
            ],
          );
        });
  }

  //Diálogo que te devuelve al listado de alumnos de curso del que se había seleccionado alumno
  crearDialogoVuelta(String nombreAlumno, String cursoAlumno, String accion) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registro Grabado'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$nombreAlumno acaba de $accion.'),
                const Text('Se ha guardado el registro!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Volver'),
              onPressed: () {
                Navigator.pushNamed(context, 'homepage');
              },
            ),
          ],
        );
      },
    );
  }
}
