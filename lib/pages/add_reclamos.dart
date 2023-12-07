import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:reclamos_anakena/models/imagenes_reclamos.dart';
import 'package:reclamos_anakena/services/image_picker.dart';
import 'package:reclamos_anakena/services/image_upload.dart';
import 'package:reclamos_anakena/services/imagenes_mongo.dart';
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
  String dropdownValue = 'Inocuidad';
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

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:20.0),
            child: Visibility(
              visible: myProvider.reclamoId != "" ? true : false,
              child: IconButton(
                  onPressed: () async {
                    List<XFile> url = await seleccionarImagen();
                    // uploadImage(url.path);
                    for (var i = 0; i < url.length; i++) {
                      String? urlImage = await uploadImage(url[i].path);
                      if (urlImage != null) {
                        var imagenes = Imagenes(
                          null,
                          urlImage,
                          myProvider.reclamoId,
                        );
                        insertarImagenesMongo(imagenes);
                      }
                    }
                    print('image ok');
                  },
                  icon: const Icon(Icons.add_a_photo_sharp)),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
           // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Center(
                  child: Image.asset(
                      'assets/images/logoAnakena.png'), // Reemplaza 'assets/logo.png' con la ruta de tu imagen de logo
                ),
              ),     const Padding(
                    padding: EdgeInsets.only(bottom:20.0),
                    child: Text('Datos Comercial',
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold,color: Colors.brown)),
                  ),
              Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                children: [
             
                  Padding(
                    padding: const EdgeInsets.only(right:20.0,bottom: 20.0),
                    child: Text(
                        'Fecha reclamo : ${_selectedDate.value.day.toString()} - ${_selectedDate.value.month.toString()} - ${_selectedDate.value.year}',
                        style: const TextStyle(fontSize: 20)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom:20.0),
                    child: OutlinedButton(
                        onPressed: () {
                          _restorableDatePickerRouteFuture.present();
                        },
                        child: const Text('Seleccionar fecha')),
                  ),
                
                ],
              ),
          
              Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    child: Padding(

                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: embarqueController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'N° de Embarque',
                          labelText: 'N° de Embarque',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:8.0),
                    child: Container(
                      width: 400,
                      child: TextField(
                        controller: nombreClienteController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Nombre de cliente',
                          labelText: 'Nombre de cliente',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 400,
                    child: TextField(
                      controller: comercialController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Comercial a cargo',
                        labelText: 'Comercial a cargo',
                      ),
                    ),
                  ),
                ],
              ),
              // crear campo de observaciones multilinea
              Container(
                width: 1003,
                child: Padding(
                  padding: const EdgeInsets.only(left:4.0,top: 20.0,bottom: 20.0),
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
              ),
              const Divider(),
              const Padding(
                    padding: EdgeInsets.only(bottom:10.0),
                    child: Text('Datos Control de calidad',
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold,color: Colors.brown)),
                  ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child:
                        Text('Tipo de reclamo', style: TextStyle(fontSize: 20)),
                  ),
                  Container(
                    width: 240,
                   // margin: const EdgeInsets.all(20.0),
                    padding: const EdgeInsets.all(10.0),
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
          
                      //  style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 3,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue ?? 'Default';
                        });
                      },
                      items: <String>['Inocuidad', 'Calidad', 'Otros']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(value),
                          ),
                        );
                      }).toList(),
                    ),
                  ), Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: 600,
                  child: TextField(
                    controller: personalController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Personal a cargo resolución',
                      labelText: 'Personal a cargo resolución',
                    ),
                  ),
                ),
              ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: 1000,
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
              ),
          
              Padding(
                padding: const EdgeInsets.only(top:30.0,bottom: 30.0),
                child: FloatingActionButton.extended(
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
                        motivoController.text,
                        dropdownValue, // Motivo
                        personalController.text, // Personal a cargo de resolución
                        resolucionController.text, // Resolución
                        'En Proceso',
                      );
                      myProvider.addReclamo(nuevoReclamo);
                      //insertarReclamo(nuevoReclamo);
                      // Navigator.pop(context);
                    },
                    icon: const Icon(Icons.save),
                    label: const Text('Ingreso de reclamo')),
              ),
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
