import 'package:intl/intl.dart';
import 'package:reclamos_anakena/barrels.dart';
import 'package:reclamos_anakena/pages/reclamos/widgets/app_bar_reclamos.dart';
import 'package:reclamos_anakena/widgets/horizontal_stepper.dart';

class DetailsReclamos extends StatefulWidget {
  final Reclamo reclamo;
  const DetailsReclamos({super.key, required this.reclamo});

  @override
  State<DetailsReclamos> createState() => _DetailsReclamosState();
}

class _DetailsReclamosState extends State<DetailsReclamos> {
  TextEditingController motivoController = TextEditingController(text: '');
  TextEditingController motivoObservacionController =
      TextEditingController(text: '');
  TextEditingController personalController = TextEditingController(text: '');
  TextEditingController otroTipoController = TextEditingController(text: '');
  TextEditingController resolucionController = TextEditingController(text: '');
  TextEditingController resolucionComercialController =
      TextEditingController(text: '');
  String dropdownValueTipoReclamo = 'Inocuidad';
  int _currentStep = 0;
  late Reclamo reclamo;
  String? userRole;
   bool _isButtonDisabled = false;

  @override
  void initState() {
    super.initState();
    motivoController = TextEditingController();
    motivoObservacionController = TextEditingController();
    personalController = TextEditingController();
    otroTipoController = TextEditingController();
    resolucionController = TextEditingController();
    reclamo = widget.reclamo;
    motivoController.text = reclamo.motivo;
    personalController.text = reclamo.personal;
    motivoObservacionController.text = reclamo.observacionMotivo;
    otroTipoController.text = reclamo.otroTipo;
    resolucionController.text = reclamo.resolucion;
    resolucionComercialController.text = reclamo.resolucionComercial;
    _currentStep = reclamo.estado == "Creado"
        ? 2
        : reclamo.estado == "Asignado"
            ? 3
            : 4;
    _loadUserRole();
  }

  Future<void> _loadUserRole() async {
    userRole = await getUserRole();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

     var myProvider = Provider.of<Myprovider>(context);

    return Scaffold(
            appBar: AppBarAdd(title: 'Detalles Reclamos',
            perfil: userRole ?? '',
        reclamo: reclamo,),
      // appBar: appBarDetails(context, reclamo),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: HorizontalStepper(
                  currentStep: _currentStep,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(30.0),
                child: LogoAnakena(),
              ),
              AreaComercial(
                  reclamo: reclamo,
                  motivoController: motivoController,
                  motivoObservacionController: motivoObservacionController,
                ),
              const SizedBox(height: 10),
              const Divider(),
              seccionCalidad(context, reclamo),
              if (reclamo.estado !=  "Creado")
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: Column(
                      children: [
                        SeccionResolucion(
                          resolucionController: resolucionController,
                          reclamo: reclamo,
                        ),
                        const SizedBox(height: 20),
                        Visibility(
                          visible: _currentStep == 4 ? true : false,
                          child: SeccionResolucionComercial(
                            resolucionComercialControler:
                                resolucionComercialController,
                            reclamo: reclamo,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                const SizedBox(),
              if (reclamo.estado != "Finalizado")
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
                  child: FloatingActionButton.extended(
                      onPressed: _isButtonDisabled ? 
                      null : 
                      () async {
                        if(reclamo.estado == "Creado"){


                          if(userRole != 'Calidad'){
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const DialogCustom(
                                      resp: 'No tienes permisos para asignar reclamos',
                                      title: 'Error');
                                });
                            return;
                          }
                          if (dropdownValueTipoReclamo == 'Otros' &&
                              otroTipoController.text.isEmpty) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const DialogCustom(
                                      resp: 'Debe ingresar un tipo de reclamo',
                                      title: 'Error');
                                });
                            return;
                          }
                          if (personalController.text.isEmpty) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const DialogCustom(
                                      resp: 'Debe ingresar un personal a cargo',
                                      title: 'Error');
                                });
                            return;
                          }
                        }
                        if(reclamo.estado == "Asignado"){
                          if(userRole != 'Calidad'){
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const DialogCustom(
                                      resp: 'No tienes permisos para ingresar resolución qc',
                                      title: 'Error');
                                });
                            return;
                          
                          }
                         if(resolucionController.text.isEmpty){
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const DialogCustom(
                                      resp: 'Debe ingresar una resolución de QC',
                                      title: 'Error');
                                });
                            return;
                          }
                          
                        }
                        if(reclamo.estado == "Resolución QC"){
                          if(userRole != 'Comercial'){
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const DialogCustom(
                                      resp: 'No tienes permisos para ingresar resolución comercial',
                                      title: 'Error');
                                });
                            return;
                          }
                          if(resolucionComercialController.text.isEmpty){
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const DialogCustom(
                                      resp: 'Debe ingresar una resolución comercial',
                                      title: 'Error');
                                });
                            return;
                          }
                        }
                        String resp = await Provider.of<Myprovider>(context,
                                listen: false)
                            .updateReclamo(
                          // reclamo.objectId!.oid,
                          Reclamo(
                            reclamo.objectId,
                            reclamo.fechaReclamo,
                            reclamo.fechaIngreso,
                            reclamo.tipo,
                            reclamo.nombreCliente,
                            reclamo.embarque,
                            reclamo.comercial,
                            motivoController.text,
                            reclamo.producto,
                            motivoObservacionController.text,
                            dropdownValueTipoReclamo == 'Otros'
                                ? otroTipoController.text
                                : dropdownValueTipoReclamo,
                            otroTipoController.text,
                            personalController.text,
                            resolucionController.text,
                            resolucionComercialController.text,
                            reclamo.estado == "Creado"
                                ? 'Asignado'
                                : reclamo.estado == "Asignado"
                                    ? 'Resolución QC'
                                    : 'Finalizado',
                            reclamo.imagenes,
                            reclamo.archivos,
                          ),
                        );
                        // if (!mounted) return;
                        // ignore: use_build_context_synchronously
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return DialogCustom(
                                  resp: resp, title: 'Respuesta');
                            });

                        _currentStep = reclamo.estado == "Creado" ? 3 : 4;
                        setState(() {
                          _isButtonDisabled = true;
                        });
                      },
                      icon: const Icon(Icons.save),
                      label: reclamo.estado == "Creado"
                          ? const Text('Asignar reclamo')
                          : reclamo.estado == "Asignado"
                              ? const Text('Resolución QC')
                              : const Text('Finalizar reclamo')),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Container seccionCalidad(BuildContext context, Reclamo reclamo) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text('Datos Control de calidad',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown)),
          ),
          //  const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (reclamo.estado == "Creado")
                Container(
                  width: 240,
                  // margin: const EdgeInsets.all(20.0),
                  padding: const EdgeInsets.all(10.0),
                  child: DropdownButton<String>(
                    value: dropdownValueTipoReclamo,
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
                        dropdownValueTipoReclamo = newValue ?? 'Default';
                      });
                    },
                    items: Constants.itemsTipoReclamo
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
                ),
              if (reclamo.estado != "Creado")
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text("Tipo reclamo: ${reclamo.tipoReclamo}",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 87, 62, 53))),
                ),
              // crear edittext para ingresar otro tipo de reclamo

              const SizedBox(
                width: 20,
              ),

              Visibility(
                visible: dropdownValueTipoReclamo == 'Otros' ? true : false,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 8,
                  child: EditTextNormal(
                      controller: otroTipoController,
                      labeltext: Constants.textoTipo,
                      hintText: Constants.textoTipo,
                      readOnly: reclamo.estado == "Finalizado" ? true : false),
                ),
              ),

              const SizedBox(height: 10),

              reclamo.estado == "Creado"
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width / 5,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: EditTextNormal(
                            controller: personalController,
                            labeltext: Constants.textoPersonal,
                            hintText: Constants.textoPersonal,
                            readOnly: reclamo.estado == "Finalizado" ? true : false),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Text("Personal a cargo: ${reclamo.personal}",
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 87, 62, 53))),
                    ),
              const SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}

class SeccionResolucion extends StatelessWidget {
  const SeccionResolucion({
    super.key,
    required this.resolucionController,
    required this.reclamo,

  });

  final TextEditingController resolucionController;
  final Reclamo reclamo;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text('Datos Resolución QC',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown)),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: resolucionController,
              readOnly: reclamo.estado == "Asignado" ? false : true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Resolución',
              ),
              style: const TextStyle(
                // fontSize: 15,
                color: Colors.brown,
              ),
              maxLines: null,
              keyboardType: TextInputType.multiline,
              
            ),
          ),
        ],
      ),
    );
  }
}

class SeccionResolucionComercial extends StatelessWidget {
  const SeccionResolucionComercial({
    super.key,
    required this.resolucionComercialControler,
    required this.reclamo,
  });

  final TextEditingController resolucionComercialControler;
  final Reclamo reclamo;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text('Datos Resolución Comercial',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown)),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: resolucionComercialControler,
              readOnly: reclamo.estado == "Resolución QC" ? false : true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Resolución',
              ),
              style: const TextStyle(
                // fontSize: 15,
                color: Colors.brown,
              ),
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
          ),
        ],
      ),
    );
  }
}

class AreaComercial extends StatelessWidget {
  const AreaComercial({
    super.key,
    required this.reclamo,
    required this.motivoController,
    required this.motivoObservacionController,
  });

  final Reclamo reclamo;
  final TextEditingController motivoController;
  final TextEditingController motivoObservacionController;


  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 2,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Text('Datos Comercial',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown)),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Fecha reclamo: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(reclamo.fechaReclamo))}",
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 78, 55, 47)),
              ),
              Text(
                "Tipo: ${reclamo.tipo}",
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 78, 55, 47)),
              ),
              Text(
                "Producto: ${reclamo.producto}",
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 78, 55, 47)),
              ),
            ],
          ),

          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Cliente: ${reclamo.nombreCliente}",
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 78, 55, 47)),
              ),
              Text(
                "N° Embarque: ${reclamo.embarque}",
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 78, 55, 47)),
              ),
              Text(
                "Comercial: ${reclamo.comercial}",
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 78, 55, 47)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: EditTextNormal(
                controller: motivoController,
                labeltext: 'Motivo',
                hintText: 'Motivo',
                readOnly: true,
                
              ),
            ),
          ),
          // observaciones de motivo
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextObservacion(
                controller: motivoObservacionController,
                labeltext: 'Observaciones motivo',
                readOnly: true,
              ),
            ),
          ),
        ]));
  }
}
