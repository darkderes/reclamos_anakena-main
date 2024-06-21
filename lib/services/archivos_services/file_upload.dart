import 'package:reclamos_anakena/barrels.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


Future<String> uploadFileSupabase(File file) async {
  // obtener nombre del archivo
  String fileName = file.path.split('\\').last;
  
   await Supabase.instance.client.storage
      .from('anakena')
      .uploadBinary('anakena/$fileName',await file.readAsBytes());
    final url = Supabase.instance.client.storage
      .from('anakena')
      .getPublicUrl('anakena/$fileName');
    return url;
 
}
