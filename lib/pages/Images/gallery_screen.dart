import 'package:reclamos_anakena/barrels.dart';

class GaleryScreen extends StatefulWidget {
  // final String proceso;
  final Reclamo reclamo;
  final String perfil;
  const GaleryScreen({super.key, required this.reclamo, required this.perfil});

  @override
  State<GaleryScreen> createState() => _GaleryScreenState();
}

class _GaleryScreenState extends State<GaleryScreen> {
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
    final provider = Provider.of<Myprovider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galeria de Imagenes'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
                onPressed: () async {
                  cargarYGuardarImagenes(context, widget.perfil, widget.reclamo)
                      .then((_) {
                    provider.getReclamoById(widget.reclamo.objectId!);
                      });
                  // await  provider.getReclamoById(widget.reclamo.objectId!);
                },
                icon: const Icon(Icons.add_a_photo_sharp)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List<Widget>>(
              future: _imagenesList(provider.reclamo, "Comercial"),
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
                        child: Text(
                          'No hay imágenes disponibles area comercial.',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }
                  return Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Imagenes subidas Comercial',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown),
                        ),
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
              future: _imagenesList(provider.reclamo, "Calidad"),
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
                      child: Text(
                        'No hay imágenes disponibles area calidad.',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                  return Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Imagenes subidas Calidad',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown),
                        ),
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
                ),
              ),
            );
          },
          //Child(),
          child: Image.network(item.url, fit: BoxFit.cover),
        ),
      );
    }
    return lista;
  }
}
