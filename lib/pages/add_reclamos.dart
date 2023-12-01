import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/reclamo.dart';
import '../services/provider_reclamos.dart';

class AddReclamos extends StatefulWidget {
  const AddReclamos({super.key});

  @override
  State<AddReclamos> createState() => _AddReclamosState();
}

class _AddReclamosState extends State<AddReclamos> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const AddReclamosPage(title: 'Ingreso de reclamo');
  }
}

class AddReclamosPage extends StatefulWidget {
  const AddReclamosPage({super.key, required this.title});

  final String title;

  @override
  State<AddReclamosPage> createState() => _AddReclamosPageState();
}

class _AddReclamosPageState extends State<AddReclamosPage>
    with RestorationMixin {
  TextEditingController nombreClienteController =
      TextEditingController(text: '');
  TextEditingController embarqueController = TextEditingController(text: '');
  TextEditingController comercialController = TextEditingController(text: '');
  TextEditingController motivoController = TextEditingController(text: '');
  TextEditingController personalController = TextEditingController(text: '');
  TextEditingController resolucionController = TextEditingController(text: '');

  @override
  String? get restorationId => "add_reclamos_page";

  final RestorableDateTime _selectedDate =
      RestorableDateTime(DateTime(2021, 7, 25));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2021),
          lastDate: DateTime(2022),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
       var myProvider = Provider.of<Myprovider>(context);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // DatePickerDialog(initialDate: DateTime(2023), firstDate: DateTime(2023), lastDate: DateTime.now()),
            // add edittext de cliente
            // DateRangePickerDialog(firstDate: DateTime(2023), lastDate: DateTime.now()),
            OutlinedButton(
                onPressed: () {
                  _restorableDatePickerRouteFuture.present();
                },
                child: const Text('Fecha de reclamo')),
            Text(
                'Fecha reclamo : ${_selectedDate.value.day.toString()} - ${_selectedDate.value.month.toString()} - ${_selectedDate.value.year}'),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: nombreClienteController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Cliente',
                  labelText: 'Nombre de cliente',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: embarqueController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'N° de Embarque',
                  labelText: 'N° de Embarque',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: comercialController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Comercial a cargo',
                  labelText: 'Comercial a cargo',
                ),
              ),
            ),
            const Divider(),
            // crear campo de observaciones multilinea
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: motivoController,
                // enabled: widget.visita.estado == "0" ? true : false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Motivo',
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: personalController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Personal a cargo resolución',
                  labelText: 'Personal a cargo resolución',
                ),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: resolucionController,
                // enabled: widget.visita.estado == "0" ? true : false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Resolución',
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
            ),

            FloatingActionButton.extended(
                onPressed: () {
                  var nuevoReclamo = Reclamo(
                    null,

                    // Id del reclamo
                    _selectedDate.value
                        .toString(), // Fecha de reclamo en formato de cadena
                    DateTime.now(), // Fecha de ingreso en formato de cadena
                    nombreClienteController.text, // Nombre de cliente
                    embarqueController.text, // N° de embarque
                    comercialController.text, // Comercial a cargo
                    motivoController.text, // Motivo
                    personalController.text, // Personal a cargo de resolución
                    resolucionController.text, // Resolución
                    'En Proceso',
                  );
                  myProvider.addReclamo(nuevoReclamo);
                  //insertarReclamo(nuevoReclamo);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.save),
                label: const Text('Ingreso de reclamo')),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
