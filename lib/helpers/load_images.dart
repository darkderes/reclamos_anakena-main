import 'package:reclamos_anakena/barrels.dart';


  Future<void> cargarYGuardarImagenes(BuildContext context,String perfil,String id) async {
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
            perfil,
            urlImage,
          );
          insertarImagenesMongo(imagenes, id);
        }
      }
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      Navigator.of(context).pop();
    }
  }
