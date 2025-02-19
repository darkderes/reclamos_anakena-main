import 'package:mongo_dart/mongo_dart.dart';
import 'package:reclamos_anakena/barrels.dart';


void insertarImagenesMongo(Imagenes imagenes,String id) async {
    String env = dotenv.get('MONGODB_URI');
  var db = await Db.create(env);
  await db.open();
  var reclamosCollection = db.collection('reclamos');
  
  var result = await reclamosCollection.updateOne(
    where.eq('_id', ObjectId.parse(id)),
    modify.push('imagenes',imagenes.toMap())
  );
  
  await db.close();
  
  if (result.isSuccess) {
    debugPrint('Imagen agregada correctamente al reclamo');
  } else {
    debugPrint('Error al agregar imagen al reclamo');
  }
}


Future<void> deleteUrlImage(String idReclamo, String url) async {
  String env = dotenv.get('MONGODB_URI', fallback: '');
  
  if (env.isEmpty) {
    debugPrint('Error: MONGODB_URI no está configurado en el .env');
    return;
  }

  Db? db;
  try {
    db = await Db.create(env);
    await db.open();
    var reclamosCollection = db.collection('reclamos');

    // Extraer solo la parte hexadecimal si el ID viene en formato ObjectId("...")
    final RegExp objectIdPattern = RegExp(r'ObjectId\("([a-fA-F0-9]{24})"\)');
    String cleanId = idReclamo;

    final match = objectIdPattern.firstMatch(idReclamo);
    if (match != null) {
      cleanId = match.group(1)!; // Obtener solo la parte hexadecimal
    }

    ObjectId objectId = ObjectId.fromHexString(cleanId);

    var result = await reclamosCollection.updateOne(
      where.eq('_id', objectId),
      modify.pull('imagenes', {'url': url}),
    );

    if (result.isSuccess) {
      debugPrint('✅ Imagen eliminada correctamente del reclamo');
    } else {
      debugPrint('⚠️ Error al eliminar imagen del reclamo');
    }
  } catch (e) {
    debugPrint('❌ Excepción al eliminar la imagen: $e');
  } finally {
    await db?.close();
  }
}
