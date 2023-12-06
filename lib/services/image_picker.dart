import 'package:image_picker/image_picker.dart';


Future<List<XFile>> seleccionarImagen () async {
  final ImagePicker picker = ImagePicker();
// Pick an image.
  final List<XFile> images = await picker.pickMultiImage();

  return images;
}