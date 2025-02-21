// me podrias crear una clase para mostrar en una lista mis archivos subidos en cloudinary
import 'package:reclamos_anakena/barrels.dart';
import 'package:url_launcher/url_launcher.dart';

class GalleryFiles extends StatefulWidget {
  final Reclamo reclamo;
  final String perfil;
  const GalleryFiles({super.key, required this.reclamo, required this.perfil});

  @override
  State<GalleryFiles> createState() => _GalleryFilesState();
}

class _GalleryFilesState extends State<GalleryFiles> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<Myprovider>(context, listen: false);
    if (widget.reclamo.objectId != null) {
      provider.getReclamoById(widget.reclamo.objectId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Myprovider>(context, listen:false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Galeria de Archivos'),
        actions: [
          IconButton(
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
                      child: LoadFiles(
                        seccion: widget.perfil,
                        reclamo: widget.reclamo,
                      ),
                    ),
                  );
                },
              ).then((_){
               provider.getReclamoById(widget.reclamo.objectId!);
              });
              // provider.getReclamoById(widget.reclamo.objectId!);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List<Widget>>(
              future: _archivosList(provider.reclamo, "Area"),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
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
                        child: Text(
                          'No hay archivos disponibles.',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  } else {
                    // Usar ListView.builder para mostrar los elementos de la lista
                    return ListView.builder(
                      shrinkWrap:
                          true, // Importante para asegurar que se muestre dentro de un SingleChildScrollView
                      physics:
                          const NeverScrollableScrollPhysics(), // Para evitar el desplazamiento dentro del ListView
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

  Future<List<Widget>> _archivosList(Reclamo reclamo, String area) async {
    List<Widget> lista = [];
    List<Archivos> archivos = [];
    archivos = reclamo.archivos;
    final provider = Provider.of<Myprovider>(context, listen: true);
    //await traerUrlArchivosMongo(proceso);
    for (var item in archivos) {
      lista.add(
        Padding(
          padding:
              const EdgeInsets.only(left: 250, right: 250, top: 10, bottom: 10),
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
                    // deleteUrlArchivo(item.url);
                    provider.deleteUrlArchivos(
                        widget.reclamo.objectId.toString(), item.url);
                    // setState(() {});
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
