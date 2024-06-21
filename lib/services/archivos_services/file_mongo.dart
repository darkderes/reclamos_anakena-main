import 'package:mongo_dart/mongo_dart.dart';
import 'package:reclamos_anakena/barrels.dart';


void insertarArchivoMongo(Archivos archivos) async {
  String env = dotenv.get('MONGODB_URI');
  var db = await Db.create(env);
  await db.open();
  var archivosCollection = db.collection('archivos');
  WriteResult result = await archivosCollection.insertOne(archivos.toMap());
  await db.close();
  if (result.ok == 1) {
    debugPrint('Archivo insertado correctamente');
  } else {
    debugPrint('Error al insertar archivo');
  }
}

Future<List<Archivos>> traerUrlArchivosMongo(String idMongo) async {
  List<Archivos> lista = [];
  String env = dotenv.get('MONGODB_URI');
  var db = await Db.create(env);
  await db.open();
  var archivosCollection = db.collection('archivos');
  var result = await archivosCollection.find(where.eq('idReclamo', idMongo)).toList();
  await db.close();
  if (result.isNotEmpty) {
    for (var item in result) {
      lista.add(Archivos.fromMap(item));
    }
  }
  return lista;
}

void deleteUrlArchivo(String url) async {
  String env = dotenv.get('MONGODB_URI');
  var db = await Db.create(env);
  await db.open();
  var archivosCollection = db.collection('archivos');
  await archivosCollection.remove(where.eq('url', url));
  await db.close();
}