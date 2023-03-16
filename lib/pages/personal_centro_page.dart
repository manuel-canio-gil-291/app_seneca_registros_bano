import 'package:flutter/material.dart';
import 'package:app_seneca_registros_bano/utils/providers.dart';
import 'package:app_seneca_registros_bano/utils/models.dart';
import 'package:url_launcher/url_launcher.dart';

class PersonalCentro extends StatelessWidget {
  final PersonalProvider persona = PersonalProvider();

  PersonalCentro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: persona.getPersonal(),
          builder: (BuildContext conext, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return _ListaPersonal(p: snapshot.data);
            }
          }),
    );
  }
}

class _ListaPersonal extends StatelessWidget {
  final List<Personal> p;

  const _ListaPersonal({required this.p});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: p.length,
        itemBuilder: (context, int index) {
          final profe = p[index];
          return ListTile(
            title: Text(profe.usuario),
            onTap: () {
              mostrarDialogo(context, p[index]);
            },
          );
        });
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
                    color: Colors.white),
                padding: const EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width * 0.8,
                height: 320,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://www.kindpng.com/picc/m/33-338711_circle-user-icon-blue-hd-png-download.png'),
                    ),
                    ListTile(
                      title: Text(
                        profe.mail,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12),
                      ),
                      onTap: () {
                        launchUrl(Uri.parse(
                            "mailto:${profe.mail}?subject=Probando Flutter&body=Hola ${profe.usuario}%20"));
                      },
                    ),
                    ListTile(
                      title: Text(
                        profe.telefono,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12),
                      ),
                      onTap: () {
                        launchUrl(Uri.parse("tel://${profe.telefono}"));
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
