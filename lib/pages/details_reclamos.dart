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
  TextEditingController resolucionController = TextEditingController(text: '');
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    Provider.of<Myprovider>(context);
    Reclamo reclamo = widget.reclamo;
    motivoController.text = reclamo.motivo;
    resolucionController.text = reclamo.resolucion;
    if (reclamo.estado == "Finalizado") {
      _isChecked = true;
    }
   
    return Scaffold(
      appBar: AppBar(

          title: const Text("Detalles Reclamos"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.collections, color: Colors.white),
              onPressed: () {
                Navigator.pushNamed(context, "/galery_screen",
                    arguments: reclamo.objectId!.toHexString());
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
                            widget.reclamo.objectId!.toHexString(),
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
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Center(
                  child: Image.asset(
                      'assets/images/logoAnakena.png'), // Reemplaza 'assets/logo.png' con la ruta de tu imagen de logo
                ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Cliente: ${reclamo.nombreCliente}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    "N° Embarque: ${reclamo.embarque}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    "Comercial: ${reclamo.comercial}",
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
                    readOnly: reclamo.estado == "Finalizado" ? true : false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Motivo',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Tipo Reclamo: ${reclamo.tipoReclamo}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    "Personal a cargo ${reclamo.personal}",
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
                    controller: resolucionController,
                    readOnly: reclamo.estado == "Finalizado" ? true : false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Resolución reclamo',
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.95,
                child: CheckboxListTile(
                  title: const Text("Resolución finalizada"),
                  value: _isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked = value!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity
                      .leading, // coloca el checkbox al inicio del texto
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
                child: Visibility(
                  visible: reclamo.estado == "Finalizado" ? false : true,
                  child: FloatingActionButton.extended(
                      onPressed: () async {
                        String resp =
                            await Provider.of<Myprovider>(context, listen: false)
                                .updateReclamo(
                          reclamo.objectId!.toHexString(),
                          motivoController.text,
                          resolucionController.text,
                          _isChecked ? "Finalizado" : "En proceso",
                        );
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
                  
                        // Navigator.pop(context);
                      },
                      icon: const Icon(Icons.save),
                      label: const Text('Actualizar de reclamo')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
