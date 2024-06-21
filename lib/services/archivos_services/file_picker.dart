import 'package:file_picker/file_picker.dart';
import 'package:reclamos_anakena/barrels.dart';

// crear future que selecciona un archivo
Future<File> seleccionarFile() async {
  // seleccionar archivo
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  // si no se selecciona archivo
  if (result == null) {
    return Future.error('No se seleccionó archivo');
  }
  // si se selecciona archivo
  File file = File(result.files.single.path!);
  return file;
  
}