import 'package:intl/intl.dart';
import 'package:reclamos_anakena/barrels.dart';

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
  String dropdownValueTipoReclamo = 'Inocuidad';

  @override
  void initState() {
    super.initState();
    motivoController = TextEditingController();
    motivoObservacionController = TextEditingController();
    personalController = TextEditingController();
    otroTipoController = TextEditingController();
    resolucionController = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    Provider.of<Myprovider>(context);
    Reclamo reclamo = widget.reclamo;
    motivoController.text = reclamo.motivo;
    personalController.text = reclamo.personal;
    motivoObservacionController.text = reclamo.observacionMotivo;
    otroTipoController.text = reclamo.otroTipo;
    resolucionController.text = reclamo.resolucion;

    return Scaffold(
      appBar: AppBar(title: const Text("Detalles Reclamos"), actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.collections, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, "/galery_screen",
                arguments: reclamo.objectId!.oid);
          },
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Visibility(
            visible: reclamo.estado == "Finalizado" ? false : true,
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
                        widget.reclamo.objectId!.oid,
                      );
                      insertarImagenesMongo(imagenes);
                    }
                  }
                  debugPrint('image ok');
                },
                icon: const Icon(
                  Icons.add_a_photo,
                  color: Colors.white,
                )),
          ),
        )
      ]),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
           
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              
              const Padding(
                padding: EdgeInsets.all(30.0),
                child: LogoAnakena(),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text('Datos Comercial',
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown)),
              ),
              Text(
                "Fecha reclamo: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(reclamo.fechaReclamo))}",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text("Tipo  ${reclamo.tipo}      Producto: ${reclamo.producto}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Cliente: ${reclamo.nombreCliente}   N° Embarque: ${reclamo.embarque}   Comercial: ${reclamo.comercial}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: TextField(
                    controller: motivoController,
                    readOnly: reclamo.estado == "Creado" ? true : false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Motivo',
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
              ),
              // observaciones de motivo
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: TextField(
                    controller: motivoObservacionController,
                    readOnly: reclamo.estado == "Creado" ? true : false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Observaciones motivo',
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
              ),

              const SizedBox(height: 10),
              const Divider(),
              const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text('Datos Control de calidad',
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown)),
              ),

              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Tipo Reclamo', style: TextStyle(fontSize: 20)),
                  ),
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
                  Text(reclamo.tipoReclamo,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  // crear edittext para ingresar otro tipo de reclamo
                ],
              ),
              const SizedBox(height: 10),

              Visibility(
                visible: dropdownValueTipoReclamo == 'Otros' ? true : false,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: EditTextNormal(
                      controller: otroTipoController,
                      labeltext: Constants.textoTipo,
                      hintText: Constants.textoTipo),
                ),
              ),

              const SizedBox(height: 10),

              reclamo.estado == "Creado"
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                        child: EditTextNormal(
                            controller: personalController,
                            labeltext: Constants.textoPersonal,
                            hintText: Constants.textoPersonal),
                      ),
                    )
                  : Text("Personal a cargo: ${reclamo.personal}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),

              reclamo.estado == "Asignado" || reclamo.estado == "Finalizado"
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                        child: Column(
                          children: [
                            const Divider(),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 10.0),
                              child: Text('Datos Resolución',
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.brown)),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: resolucionController,
                              readOnly:
                                  reclamo.estado == "Finalizado" ? true : false,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Resolución',
                              ),
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(),


              if (reclamo.estado != "Finalizado")
              Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
                child: FloatingActionButton.extended(
                    onPressed: () async {
                      String resp =
                          await Provider.of<Myprovider>(context, listen: false)
                              .updateReclamo(
                        reclamo.objectId!.oid,
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
                          reclamo.estado == "Creado" ? 'Asignado' : 'Finalizado',
                        ),
                      );
                      // if (!mounted) return;
                      // ignore: use_build_context_synchronously
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Respuesta'),
                            content: Text(resp),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );

                   //   setState(() {});
                    },
                    icon: const Icon(Icons.save),
                    label: reclamo.estado == "Creado" ? const Text('Asignar reclamo') : const Text('Finalizar reclamo')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
