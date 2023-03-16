import 'package:flutter/material.dart';
import 'package:app_seneca_registros_bano/utils/models.dart';
import 'package:app_seneca_registros_bano/utils/providers.dart';

class ProfesoresDatos extends StatelessWidget {
  final PersonalProvider persona = PersonalProvider();

  ProfesoresDatos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: persona.getPersonal(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return _ListaProfesor(p: snapshot.data);
          }
        }
      ),
    );
  }
}

class _ListaProfesor extends StatelessWidget {
  final List<Personal> p;

  const _ListaProfesor({required this.p});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: p.length,
      itemBuilder: (context, int index) {
        return ListTile(
          onTap: () {
            mostrarDialogo(context, p[index]);
          },
        );
      }
    );
  }

  mostrarDialogo(context, profe) {
    return showDialog(
      context: context, 
      builder: (context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blueAccent 
              ),
              padding: const EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width * 0.4,
              height: 220,
            ),
          ),
        );
      }
    );
  }
}