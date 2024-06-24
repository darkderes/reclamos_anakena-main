// me podrias crear una clase para mostrar en una lista mis archivos subidos en cloudinary
import 'package:reclamos_anakena/barrels.dart';
import 'package:url_launcher/url_launcher.dart';

class GalleryFiles extends StatefulWidget {
  final String proceso;
  const GalleryFiles({super.key,required this.proceso});

  @override
  State<GalleryFiles> createState() => _GalleryFilesState();
}

class _GalleryFilesState extends State<GalleryFiles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galeria de Archivos'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
           FutureBuilder<List<Widget>>(
  future: _archivosList(widget.proceso, "Area"),
  builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Padding(
        padding: EdgeInsets.all(28.0),
        child: Center(child: CircularProgressIndicator()),
      );
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else if (snapshot.hasData) {
      if (snapshot.data!.isEmpty) {
        return const Padding(
          padding: EdgeInsets.all(15.0),
          child: Center(
            child: Text('No hay archivos disponibles.', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)  ,
          ),
        );
      } else {
        // Usar ListView.builder para mostrar los elementos de la lista
        return ListView.builder(
          shrinkWrap: true, // Importante para asegurar que se muestre dentro de un SingleChildScrollView
          physics: const NeverScrollableScrollPhysics(), // Para evitar el desplazamiento dentro del ListView
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return snapshot.data![index];
          },
        );
      }
    } else {
      // En caso de que no haya datos
      return const Text('No se encontraron datos.');
    }
  },
),
          ],
        ),
      ),
    );
  }

  Future<List<Widget>> _archivosList(String proceso, String area) async {
    List<Widget> lista = [];
    List<Archivos> archivos = await traerUrlArchivosMongo(proceso);
    for (var item in archivos) {
      lista.add(
        Padding(
          padding: const EdgeInsets.only(left: 250, right: 250, top: 10, bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ 
                 Text(
                  item.etiqueta,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 120),
               InkWell(
              onTap: () async {
                
    //               String url = item.url; // La URL desde donde descargar el archivo
    // Dio dio = Dio();

    // try {
    //   // Obtener el directorio de documentos del dispositivo
    //   Directory directorio = await getApplicationDocumentsDirectory();
    //   String ruta = '${directorio.path}/${url.split('/').last}';

    //   // Descargar el archivo
    //   await dio.download(url, ruta);

    //   // Mostrar un mensaje de éxito (opcional)
    //   print('Archivo descargado y guardado en $ruta');
    // } catch (e) {
    //   print('Error al descargar el archivo: $e');
    // }

                // necesito que al presionar el boton descargar se descargue el archivo


               launchUrl(Uri.parse(item.url));
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.download), // Icono de descarga
                    Text('Descargar'), // Texto indicativo
                  ],
                ),
              ),
            ),
               InkWell(
              onTap: () {
              deleteUrlArchivo(item.url);
              setState(() {});
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.delete_sweep_rounded), // Icono de descarga
                    Text('Eliminar'), // Texto indicativo
                  ],
                ),
              ),
            ),
               
              ],
            ),
          ),
        ),
      );
    }
    return lista;
  }
}
