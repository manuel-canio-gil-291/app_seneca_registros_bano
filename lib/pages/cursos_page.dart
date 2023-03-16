import 'package:flutter/material.dart';
import 'package:app_seneca_registros_bano/utils/models.dart';
import 'package:app_seneca_registros_bano/utils/providers.dart';

class CursosPage extends StatelessWidget {
  final CursosProvider grupo = CursosProvider();

  CursosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cursos del Centro'),
      ),
      body: FutureBuilder(
          future: grupo.getCursos(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return _ListaGrupos(lisCursos: snapshot.data);
            }
          }),
    );
  }
}

class _ListaGrupos extends StatelessWidget {
  final List<Grupo> lisCursos;

  const _ListaGrupos({required this.lisCursos});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: lisCursos.length,
        itemBuilder: (context, int index) {
          final curso = lisCursos[index];
          return ListTile(
            title: Text(curso.cursos),
            onTap: () {
              Navigator.pushNamed(context, 'alumnos', arguments: curso.cursos);
            },
          );
        });
  }
}
