import 'package:flutter/material.dart';
import 'package:app_seneca_registros_bano/utils/pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[Text('Index 0: Inicio')];

  void _onItemTipped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    const LoginPage args = LoginPage();

    return Scaffold(
      body: Stack(
        children: <Widget>[
          _widgetOptions.elementAt(_selectedIndex),
          _titulo(width, height),
          _tarjeta(width, height, args),
          _tabla(width, height)
        ],
      ),
    );
  }

  Widget _titulo(width, height) {
    return Container(
      padding: const EdgeInsets.only(top: 45.0),
      color: Colors.blue[800],
      height: height * 0.2,
      width: width,
      child: const Text(
        'iSéneca',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 40.0, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget _tarjeta(width, height, args) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      height: height * 0.55,
      width: width * 0.95,
      child: Center(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'Caño Gil, Manuel',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(width: 110.0),
                  IconButton(
                    icon:
                        const Icon(Icons.arrow_drop_down, color: Colors.black),
                    onPressed: () {},
                  ),
                  const Icon(Icons.people, color: Colors.black),
                  const SizedBox(width: 10.0)
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 240.0),
                child: Text(
                  'IES Jándula',
                  style: TextStyle(
                      color: Colors.blue[700], fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 225.0, top: 5.0),
                child: Text(
                  'Perfil Dirección',
                  style: TextStyle(
                      color: Colors.blue[700], fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 25.0),
                color: Colors.lightBlue,
                height: height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ElevatedButton(
                        onPressed: null,
                        child: Row(
                          children: [
                            const SizedBox(width: 15.0),
                            const Icon(Icons.alarm, color: Colors.white),
                            const SizedBox(width: 15.0),
                            const Text(
                              'Avisos',
                              textAlign: TextAlign.right,
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(width: 10.0),
                            const VerticalDivider(color: Colors.white),
                            ElevatedButton(
                                onPressed: null,
                                child: Row(
                                  children: const [
                                    Icon(Icons.library_books,
                                        color: Colors.white),
                                    SizedBox(width: 8.0),
                                    Text(
                                      'Bandeja de firmas',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ))
                          ],
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabla(width, height) {
    return Container(
      padding: const EdgeInsets.only(top: 350.0),
      child: Table(
        border: const TableBorder(
            verticalInside: BorderSide(
                width: 1, color: Colors.grey, style: BorderStyle.solid),
            horizontalInside: BorderSide(
                width: 1, color: Colors.grey, style: BorderStyle.solid)),
        children: [
          TableRow(children: [
            _crearBoton(Icons.school, 'Alumnado del centro'),
            _crearBoton(Icons.perm_media, 'Personal del centro'),
            _crearBoton(Icons.local_hospital, 'Información del Covid')
          ]),
          TableRow(children: [
            _crearbotonRegistrosTotales(Icons.assignment, 'Registros Totales'),
            _crearbotonRegistros(
                Icons.assignment_rounded, 'Registros Filtrado'),
            _crearBotonToilet(
                Icons.airline_seat_legroom_normal_outlined, 'Baño')
          ])
        ],
      ),
    );
  }

  Widget _crearBoton(IconData icono, String texto) {
    return Container(
      height: 110.0,
      margin: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    icono,
                    color: Colors.lightBlue[300],
                    size: 40.0,
                  )),
              const SizedBox(height: 10.0),
              Text(texto,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold))
            ],
          )
        ],
      ),
    );
  }

  //Widget para acceder al menu del baño
  Widget _crearBotonToilet(IconData icono, String texto) {
    return Container(
      height: 110.0,
      margin: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Column(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'cursos');
                  },
                  icon: Icon(icono, color: Colors.lightBlue[300], size: 40.0)),
              const SizedBox(height: 10.0),
              Text(texto,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold))
            ],
          )
        ],
      ),
    );
  }

  //Widget para barra de navegación homepage(opcional)
  Widget _barraNavegacion() {
    return BottomNavigationBar(
      elevation: 40.0,
      iconSize: 20.0,
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.grey), label: 'Inicio'),
        BottomNavigationBarItem(
            icon: Icon(Icons.schedule, color: Colors.grey), label: 'Agenda'),
        BottomNavigationBarItem(
            icon: Icon(Icons.message, color: Colors.grey),
            label: 'Comunicaciones'),
        BottomNavigationBarItem(
            icon: Icon(Icons.menu, color: Colors.grey), label: 'Menú'),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue[700],
      onTap: _onItemTipped,
    );
  }

  //Método para crear el botón de informes
  Widget _crearbotonRegistros(IconData icono, String texto) {
    return Container(
      height: 110.0,
      margin: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              IconButton(
                  icon: Icon(
                    icono,
                    color: Colors.lightBlue[300],
                    size: 40.0,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, 'calendario');
                  }),
              const SizedBox(height: 10.0),
              Text(texto,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }

  //Método para crear el botón de regisros totales
  Widget _crearbotonRegistrosTotales(IconData icono, String texto) {
    return Container(
      height: 110.0,
      margin: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              IconButton(
                  icon: Icon(
                    icono,
                    color: Colors.lightBlue[300],
                    size: 40.0,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, 'filtro');
                  }),
              const SizedBox(height: 10.0),
              Text(texto,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }
}
