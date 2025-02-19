import 'package:reclamos_anakena/barrels.dart';

Future<String> uploadFileSupabase(File file) async {
  // obtener nombre del archivo
  String fileName = file.path.split('\\').last;

  try  {
    // subir archivo a supabase
    await Supabase.instance.client.storage
        .from('anakena')
        .uploadBinary('anakena/$fileName', await file.readAsBytes());
    // obtener url del archivo subido
    final url = Supabase.instance.client.storage
        .from('anakena')
        .getPublicUrl('anakena/$fileName');
    return url;
  } catch (e) {
    return e.toString();
  }

 
}
