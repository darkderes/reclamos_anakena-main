import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:reclamos_anakena/models/reclamo.dart';

Future<String> insertarReclamo(Reclamo reclamo) async {
  String env = dotenv.get('MONGODB_URI');
  var db = await Db.create(env);
  await db.open();
  var reclamosCollection = db.collection('reclamos');
  WriteResult result = await reclamosCollection.insertOne(reclamo.toMap());
  await db.close();
  if (result.ok == 1) {
    return result.id.toHexString();
  } else {
    return 'Error al insertar reclamo';
  }
}

Future<List<Reclamo>> obtenerReclamos() async {
  // Conectarse a la base de datos MongoDB

  var env = dotenv.get('MONGODB_URI');
  var db = await Db.create(env.toString());

  await db.open();

  // Obtener la colección de reclamos
  var reclamosCollection = db.collection('reclamos');

  // Consultar todos los documentos en la colección
  var reclamosData = await reclamosCollection.find().toList();

  // Cerrar la conexión a la base de datos
  await db.close();

  // Convertir los documentos en reclamos
  List<Reclamo> reclamos = reclamosData.map((data) {
    return Reclamo(
      data['_id'],
      data['fechaReclamo'],
      data['fechaIngreso'],
      data['nombreCliente'],
      data['embarque'],
      data['comercial'],
      data['motivo'],
      data['tipoReclamo'],
      data['personal'],
      data['resolucion'],
      data['estado'],
    );
  }).toList();

  return reclamos;
}

Future<String> modificarReclamo(String id, String nuevoMotivo, String nuevaResolucion) async {
  var env = dotenv.get('MONGODB_URI');
  var db = await Db.create(env.toString());

  await db.open();

  var reclamosCollection = db.collection('reclamos');

  var result = await reclamosCollection.updateOne(
    where.eq('_id', ObjectId.parse(id)),
    modify.set('motivo', nuevoMotivo).set('resolucion', nuevaResolucion),
  );

  await db.close();


 if (result.ok == 1) {
    return 'Reclamo modificado';
  } else {
    return 'Error al modificar reclamo';
  }
}

