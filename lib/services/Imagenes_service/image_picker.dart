import 'package:reclamos_anakena/barrels.dart';


Future<List<XFile>> seleccionarImagen () async {
  final ImagePicker picker = ImagePicker();
// Pick an image.
  final List<XFile> images = await picker.pickMultiImage();

  return images;
}