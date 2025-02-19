import 'package:reclamos_anakena/barrels.dart';

class ViewImage extends StatefulWidget {
  final String url;
  final String estado;
  final String idReclamo;
  final VoidCallback refreshGallery;

  const ViewImage(
      {super.key,
      required this.url,
      required this.estado,
      required this.idReclamo,
      required this.refreshGallery});

  @override
  // ignore: library_private_types_in_public_api
  _ViewImageState createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
// Widget de carga inicial
  @override
  void initState() {
    super.initState();
    loadImage();
  }

  Future<void> loadImage() async {
   
    setState(
        () {}); // Actualiza la interfaz de usuario después de cargar la imagen
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                Visibility(
                  visible: widget.estado == "0" ? true : false,
                  child: IconButton(
                    onPressed: () {
                       deleteUrlImage(widget.idReclamo,widget.url);
                      widget.refreshGallery();
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context, true);
                    },
                    icon: const Icon(Icons.delete, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Center(
                // child: Hero(
                //   tag: widget.url,
                   child: Image.network(widget.url, fit: BoxFit.cover,)

                // ),
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}