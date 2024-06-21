import 'package:mongo_dart/mongo_dart.dart';
import 'package:reclamos_anakena/barrels.dart';


void insertarImagenesMongo(Imagenes imagenes) async {
  String env = dotenv.get('MONGODB_URI');
  var db = await Db.create(env);
  await db.open();
  var imagenesCollection = db.collection('imagenes');
  WriteResult result = await imagenesCollection.insertOne(imagenes.toMap());
  await db.close();
  if (result.ok == 1) {
    debugPrint('Imagenes insertado correctamente');
  } else {
    debugPrint('Error al insertar imagenes');
  }
}

 Future<List<Imagenes>> traerUrlImagenesMongo(String idMongo) async {
  List<Imagenes> lista = [];
  String env = dotenv.get('MONGODB_URI');
  var db = await Db.create(env);
  await db.open();
  var imagenesCollection = db.collection('imagenes');
  var result = await imagenesCollection.find(where.eq('idReclamo', idMongo)).toList();
  await db.close();
  if (result.isNotEmpty) {
    for (var item in result) {
      lista.add(Imagenes.fromMap(item));
    }
  }
  return lista;
}
void deleteUrlImage(String url) async {
  String env = dotenv.get('MONGODB_URI');
  var db = await Db.create(env);
  await db.open();
  var imagenesCollection = db.collection('imagenes');
  await imagenesCollection.remove(where.eq('url', url));
  await db.close();
} 
