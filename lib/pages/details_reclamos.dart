import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:reclamos_anakena/models/imagenes_reclamos.dart';
import 'package:reclamos_anakena/models/reclamo.dart';
import 'package:reclamos_anakena/services/image_picker.dart';
import 'package:reclamos_anakena/services/image_upload.dart';
import 'package:reclamos_anakena/services/imagenes_mongo.dart';

class DetailsReclamos extends StatefulWidget {
  final Reclamo reclamo;
  const DetailsReclamos({super.key, required this.reclamo});

  @override
  State<DetailsReclamos> createState() => _DetailsReclamosState();
}

class _DetailsReclamosState extends State<DetailsReclamos> {
  TextEditingController motivoController = TextEditingController(text: '');
  TextEditingController resolucionController = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    Reclamo reclamo = widget.reclamo;
    motivoController.text = reclamo.motivo;
    resolucionController.text = reclamo.resolucion;
    return Scaffold(
      appBar: AppBar(
  //       iconTheme: IconThemeData(
  //       size: 40,  
  //   color: Colors.white, //change your color here
  // ),
          title: const Text("Detalles Reclamos"),  
         
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.save, color: Colors.white),
              onPressed: () {
                 Navigator.pushNamed(context, "/galery_screen",
                    arguments: reclamo.objectId!.toHexString());
              },
            ),
             IconButton(
              onPressed: () async {
                List<XFile> url = await seleccionarImagen();
               // uploadImage(url.path);
                for (var i = 0; i < url.length; i++) {
                  String? Url = await uploadImage(url[i].path);
                  if (Url != null) {
                    var imagenes = Imagenes(
                        null,
                        Url,
                        widget.reclamo.objectId!.toHexString(),);
                    insertarImagenesMongo(imagenes);
                  }
                }
                print('image ok');
              },
              icon: const Icon(Icons.upload_file, color: Colors.white,))
          ]),
      body: 
      
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
              Padding(
              padding: const EdgeInsets.all(30.0),
              child: Center(
                child: Image.asset('assets/images/logoAnakena.png'), // Reemplaza 'assets/logo.png' con la ruta de tu imagen de logo
              ),
            ),
            Text(
              "Fecha reclamo: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(reclamo.fechaReclamo))}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Cliente: ${reclamo.nombreCliente}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "N° Embarque: ${reclamo.embarque}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Comercial: ${reclamo.comercial}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(2.0),
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
            const SizedBox(height: 10),
            Text(
              "Tipo Reclamo: ${reclamo.tipoReclamo}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Personal a cargo ${reclamo.personal}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: TextField(
                controller: resolucionController,
                // enabled: widget.visita.estado == "0" ? true : false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Resolución reclamo',
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
