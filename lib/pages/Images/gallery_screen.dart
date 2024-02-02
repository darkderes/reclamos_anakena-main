import 'package:flutter/material.dart';
import 'package:reclamos_anakena/pages/Images/view_image.dart';
import 'package:reclamos_anakena/services/Imagenes_service/imagenes_mongo.dart'; // Agrega esta importación


class GaleryScreen extends StatefulWidget {
  final String proceso;
  const GaleryScreen({Key? key, required this.proceso}) : super(key: key);

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
      body: FutureBuilder<List<Widget>>(
        future: _imagenesList(widget.proceso),
        builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.extent(
                maxCrossAxisExtent: 600,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                children: snapshot.data!),
            );
            
          } else {
            return const Center(
              child: Text('No hay imágenes disponibles.'),
            );
          }
        },
      ),
    );
  }

  Future<List<Widget>>  _imagenesList(String proceso) async {
    List<Widget> lista = [];

    List<String> imagenes = await traerUrlImagenesMongo(proceso);

    for (var item in imagenes) {
      lista.add(
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ViewImage(url: item, estado: "0", refreshGallery: _refreshGallery,)));
          },
          child: Image.network(item, fit: BoxFit.cover,)));   
    }
    return lista;
  }
    void _refreshGallery() {
    // Refresh your image list here
    setState(() {});
  }
}
