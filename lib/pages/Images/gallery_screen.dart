import 'package:reclamos_anakena/barrels.dart';

class GaleryScreen extends StatefulWidget {
  // final String proceso;
  final Reclamo reclamo;
  const GaleryScreen({super.key, required this.reclamo});

  @override
  State<GaleryScreen> createState() => _GaleryScreenState();
}

class _GaleryScreenState extends State<GaleryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galeria de Imagenes'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List<Widget>>(
              future: _imagenesList(widget.reclamo, "Comercial"),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      // child: CircularProgressIndicator(),
                      );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Center(
                        child: Text('No hay imágenes disponibles area comercial.',style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                    );
                  }
                  return Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Imagenes subidas Comercial', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color:Colors.brown),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 400, // Ajusta la altura según sea necesario
                          child: GridView.extent(
                            maxCrossAxisExtent: 600,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            children: snapshot.data!,
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: Text('No hay imágenes disponibles.'),
                  );
                }
              },
            ),
            FutureBuilder<List<Widget>>(
              future: _imagenesList(widget.reclamo, "Calidad"),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(

                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {

                  if (snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('No hay imágenes disponibles area calidad.',style: TextStyle(fontWeight: FontWeight.bold),),
                    );
                  }
                  return Column(
                    children:  [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Imagenes subidas Calidad', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color:Colors.brown),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 400, // Ajusta la altura según sea necesario
                          child: GridView.extent(
                            maxCrossAxisExtent: 600,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            children: snapshot.data!,
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: Text('No hay imágenes disponibles.'),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Widget>> _imagenesList(Reclamo reclamo, String section) async {
    List<Widget> lista = [];

     List<Imagenes> imagenes = reclamo.imagenes;

    // Filtrar imágenes por sección
    if (section != "0") {
      List<Imagenes> imagenesFiltradas = [];
      for (var item in imagenes) {
        if (item.seccion.contains(section)) {
          imagenesFiltradas.add(item);
        }
      }
      imagenes = imagenesFiltradas;
    }

    for (var item in imagenes) {
      lista.add(
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewImage(
                  url: item.url,
                  estado: "0",
                  idReclamo: reclamo.objectId.toString(),
                  refreshGallery: _refreshGallery,
                ),
              ),
            );
          },
          //Child(),
          child:
           Image.network(item.url, fit: BoxFit.cover),
        ),
      );
    }
    return lista;
  }

  void _refreshGallery() {
    // Refresh your image list here
    setState(() {});
  }
}
