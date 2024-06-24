import 'package:reclamos_anakena/barrels.dart';

// ignore: must_be_immutable
class LoadImages extends StatefulWidget {
  String? id;
  LoadImages({super.key, required this.id});

  @override
  State<LoadImages> createState() => _LoadImagesState();
}

class _LoadImagesState extends State<LoadImages> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Selecciona una sección'),
      content: DropdownButton<String>(
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
      actions: <Widget>[
        TextButton(
          child: const Text('Aceptar'),
          onPressed: () async {
            await cargarYGuardarImagenes();
            // Cierra el diálogo
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Future<void> cargarYGuardarImagenes() async {
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
      List<XFile> url = await seleccionarImagen();

      for (var i = 0; i < url.length; i++) {
        String? urlImage = await uploadImage(url[i].path);
        
        if (urlImage != null) {
          var imagenes = Imagenes(
            null,
            selectedValue ?? 'Comercial',
            urlImage,
            widget.id ?? '0',
          );
          insertarImagenesMongo(imagenes);
        }
      }
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      Navigator.of(context).pop();
    }
  }
}
