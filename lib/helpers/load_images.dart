import 'package:reclamos_anakena/barrels.dart';


  Future<void> cargarYGuardarImagenes(BuildContext context,String perfil,Reclamo reclamo) async {
    //llamar a mi provider
    final provider = Provider.of<Myprovider>(context, listen: false);
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
           
            perfil,
            urlImage,
          );
          // como hago para modificar mi reclamo con las imagenes
           reclamo.imagenes.add(imagenes);
           provider.updateReclamo(reclamo);
        
        }
      }
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      Navigator.of(context).pop();
    }
  }
