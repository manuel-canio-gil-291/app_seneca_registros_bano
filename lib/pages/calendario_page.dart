import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarioPage extends StatefulWidget {
  const CalendarioPage({super.key});

  @override
  State<CalendarioPage> createState() => _CalendarioPageState();
}

class _CalendarioPageState extends State<CalendarioPage> {
  CalendarController fechaInicio = CalendarController(),
      fechaFin = CalendarController();
  @override
  void initState() {
    super.initState();
    fechaInicio = CalendarController();
    fechaFin = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Seleccione el periodo de fechas'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: calendarioInicio()),
                  const SizedBox(width: 100.0),
                  Expanded(child: calendarioFin())
                ],
              ),
              const SizedBox(height: 50.0),
              Center(
                child: TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.all(16.0),
                      textStyle: const TextStyle(fontSize: 20)),
                  onPressed: () {
                    //Formateamos la fecha de inicio
                    String todo1 = fechaInicio.selectedDate!.toString();
                    String fechaInicioFormateada = formatearFecha(todo1);

                    String todo2 = fechaFin.selectedDate!.toString();
                    String fechaFinFormateada = formatearFecha(todo2);

                    //Pasamos los parámetros formateados a la siguiente página
                    Navigator.pushNamed(context, 'informes',
                        arguments:
                            '$fechaInicioFormateada;$fechaFinFormateada');
                  },
                  child: const Text('Consultar Registros'),
                ),
              )
            ],
          ),
        ));
  }

  Widget calendarioInicio() {
    return SfCalendar(
      view: CalendarView.month,
      todayHighlightColor: Colors.blue,
      showNavigationArrow: true,
      firstDayOfWeek: DateTime.monday,
      controller: fechaInicio,
      monthViewSettings: const MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
      headerStyle: const CalendarHeaderStyle(
          backgroundColor: Colors.blue,
          textAlign: TextAlign.center,
          textStyle: TextStyle(color: Colors.white)),
    );
  }

  Widget calendarioFin() {
    return SfCalendar(
      view: CalendarView.month,
      todayHighlightColor: Colors.blue,
      showNavigationArrow: true,
      firstDayOfWeek: DateTime.monday,
      controller: fechaFin,
      monthViewSettings: const MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
      headerStyle: const CalendarHeaderStyle(
          backgroundColor: Colors.blue,
          textAlign: TextAlign.center,
          textStyle: TextStyle(color: Colors.white)),
    );
  }

  formatearFecha(String todo) {
    int separadorFechaHora = todo.indexOf(' ');
    String diaInicio = todo.substring(0, separadorFechaHora);
    int separaAno = diaInicio.indexOf('-');
    String ano = diaInicio.substring(0, separaAno);
    String mesDia = diaInicio.substring(separaAno + 1);
    int separaMes = mesDia.indexOf('-');
    String mes = mesDia.substring(0, separaMes);
    String dia = mesDia.substring(separaMes + 1);
    String fechaFormateada = '$dia/$mes/$ano';
    return fechaFormateada;
  }
}
