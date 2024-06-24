import 'package:reclamos_anakena/barrels.dart';


// ignore: must_be_immutable
class LoadFiles extends StatefulWidget {
  String? id;
  LoadFiles({super.key, required this.id});

  @override
  State<LoadFiles> createState() => _LoadFilesState();
}

class _LoadFilesState extends State<LoadFiles> {
  String? selectedValue;
  String labelText = ''; 

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Selecciona una sección'),
     content: SingleChildScrollView( // Asegura que el contenido se muestre correctamente en pantallas pequeñas
      child: ListBody(
        children: <Widget>[
          DropdownButton<String>(
            value: selectedValue,
            hint: const Text('Selecciona'),
            onChanged: (newValue) {
              setState(() {
                selectedValue = newValue;
              });
            },
            items: Constants.itemsSection
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          TextField(
            onChanged: (value) {
              setState(() {
                labelText = value;
              });
            },
            decoration: const InputDecoration(
              labelText: 'Etiqueta',
              hintText: 'Ingresa una etiqueta',
            ),
          ),
        ],
      ),
    ),
      actions: <Widget>[
        TextButton(
          child: const Text('Aceptar'),
          onPressed: () async {
            await cargarYGuardarFiles();
            // Cierra el diálogo
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Future<void> cargarYGuardarFiles() async {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Impide que el diálogo se cierre al tocar fuera
      builder: (BuildContext context) {
        return const Dialog(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text("Cargando..."),
              ],
            ),
          ),
        );
      },
    );
    try {
      File files = await seleccionarFile();
      if (files != null) {
     //   String? urlFile = await uploadFile(files.path);
        String? urlFile =  await uploadFileSupabase(files);
        Archivos archivo = Archivos(
          null,
            selectedValue ?? 'Comercial',
            urlFile ,
            labelText,
            widget.id ?? '0',
        );
        insertarArchivoMongo(archivo);
      }
    } catch (e) {
      debugPrint('Error al cargar archivo: $e');
    } finally {
      Navigator.of(context).pop();
    }
  }
}
