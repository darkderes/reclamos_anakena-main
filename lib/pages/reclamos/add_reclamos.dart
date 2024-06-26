import 'package:reclamos_anakena/barrels.dart';
import 'package:reclamos_anakena/widgets/horizontal_stepper.dart';

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
  TextEditingController observacionMotivoController =
      TextEditingController(text: '');
  TextEditingController motivoController = TextEditingController(text: '');
  TextEditingController productoController = TextEditingController(text: '');
  String dropdownValueTipo = 'Reclamo';
  int _currentStep = 1;

  @override
  String? get restorationId => "add_reclamos_page";

  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());
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
          firstDate: DateTime.now().subtract(const Duration(days: 365)),
          lastDate: DateTime.now(),
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
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Visibility(
            visible: _currentStep == 2 ? true : false,
            child: IconButton(
              icon: const Icon(Icons.all_inbox_rounded, color: Colors.white),
              onPressed: () {
                Navigator.pushNamed(context, "/galery_files",
                    arguments: myProvider.reclamoId);
              },
            ),
          ),
          Visibility(
            visible: _currentStep == 2 ? true : false,
            child: IconButton(
              icon: const Icon(Icons.cloud_download_sharp, color: Colors.white),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: SizedBox(
                        // Puedes ajustar el tamaño del contenedor según tus necesidades
                        width: 500,
                        height: 300,
                        child: LoadFiles(id: myProvider.reclamoId),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Visibility(
            visible: _currentStep == 2 ? true : false,
            child: IconButton(
              icon: const Icon(Icons.collections, color: Colors.white),
              onPressed: () {
                Navigator.pushNamed(context, "/galery_screen",
                    arguments: myProvider.reclamoId);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Visibility(
              visible: _currentStep == 2 ? true : false,
              child: IconButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          child: SizedBox(
                            // Puedes ajustar el tamaño del contenedor según tus necesidades
                            width: 500,
                            height: 300,
                            child: LoadImages(id: myProvider.reclamoId),
                          ),
                        );
                      },
                    );
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
                padding: const EdgeInsets.all(8.0),
                child: HorizontalStepper(
                  currentStep: _currentStep,
                ),
              ),
              // Reemplaza 'assets/logo.png' con la ruta de tu imagen de logo
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 30.0),
                child: Center(
                  child:
                      LogoAnakena(), // Reemplaza 'assets/logo.png' con la ruta de tu imagen de logo
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(
                        0,
                        0,
                      ),
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20.0),
                      child:
                          TextTitle(titlle: 'Datos de reclamo', fontSize: 26),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 20.0, bottom: 20.0),
                          child: Text(
                              'Fecha reclamo : ${_selectedDate.value.day.toString()} - ${_selectedDate.value.month.toString()} - ${_selectedDate.value.year}',
                              style: const TextStyle(fontSize: 20)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: IconButton(
                            icon: const Icon(Icons.calendar_month_outlined),
                            onPressed: () {
                              _restorableDatePickerRouteFuture.present();
                            },
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                              bottom: 20.0, left: 20.0, right: 20.0),
                          child: Text('Tipo', style: TextStyle(fontSize: 20)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: SizedBox(
                            width: 150,
                            // margin: const EdgeInsets.all(20.0),
                            // padding: const EdgeInsets.all(10.0),
                            child: DropdownButton<String>(
                              value: dropdownValueTipo,
                              isExpanded: true,
                              icon: const Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,

                              //  style: const TextStyle(color: Colors.deepPurple),
                              underline: Container(
                                height: 3,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValueTipo = newValue ?? 'Default';
                                });
                              },
                              items: Constants.itemsTipo
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(value),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width / 5,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: EditTextNormal(
                                controller: productoController,
                                labeltext: Constants.textoProducto,
                                hintText: Constants.textoProducto),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: EditTextNormal(
                                controller: embarqueController,
                                labeltext: Constants.textoEmbarque,
                                hintText: Constants.textoEmbarque),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: SizedBox(
                            width: 400,
                            child: EditTextNormal(
                                controller: nombreClienteController,
                                labeltext: Constants.textoCliente,
                                hintText: Constants.textoCliente),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SizedBox(
                            width: 400,
                            child: EditTextNormal(
                                controller: comercialController,
                                labeltext: Constants.textoComercialCargo,
                                hintText: Constants.textoComercialCargo),
                          ),
                        ),
                      ],
                    ),

                    const Divider(),
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child:
                          TextTitle(titlle: 'Datos de reclamo', fontSize: 26),
                    ),
                    // crear campo de edittext normal con producto y otro de motivo
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: width / 4,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, top: 20.0),
                            child: EditTextNormal(
                                controller: motivoController,
                                labeltext: Constants.textoMotivo,
                                hintText: Constants.textoMotivo),
                          ),
                        ),
                      ],
                    ),
                    // crear campo de observaciones multilinea
                    SizedBox(
                      width: width / 1.5,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextObservacion(
                            controller: observacionMotivoController,
                            labeltext: 'Observaciones Motivo'),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
                      child: FloatingActionButton.extended(
                          onPressed: () {
                            var nuevoReclamo = Reclamo(
                              null,

                              // Id del reclamo
                              _selectedDate.value
                                  .toString(), // Fecha de reclamo en formato de cadena
                              DateTime
                                  .now(), // Fecha de ingreso en formato de cadena
                              dropdownValueTipo, // Tipo de reclamo
                              nombreClienteController.text, // Nombre de cliente
                              embarqueController.text, // N° de embarque
                              comercialController.text,
                              motivoController.text,
                              productoController.text,
                              observacionMotivoController.text,
                              "", // Tipo de reclamo
                              "", // Otro tipo
                              "", // Personal a cargo de resolución
                              "", // Resolución
                              'Creado',
                            );
                            if (myProvider.reclamoId == "") {
                              myProvider.addReclamo(nuevoReclamo);
                              sendEmail(nuevoReclamo);
                            } else {
                              myProvider.updateReclamo(
                                  myProvider.reclamoId, nuevoReclamo);
                            }
                            // myProvider.addReclamo(nuevoReclamo);
                            String resp = myProvider.reclamoId == "0"
                                ? "Ocurrio un error"
                                : "Reclamo guardado correctamente";
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(resp),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Aceptar'),
                                    ),
                                  ],
                                );
                              },
                            );
                            setState(() {
                              _currentStep = resp == "Ocurrio un error" ? 1 : 2;
                            });
                          },
                          icon: const Icon(Icons.save),
                          label: const Text('Ingreso de reclamo')),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
