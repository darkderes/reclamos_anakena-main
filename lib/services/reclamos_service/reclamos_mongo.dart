import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:reclamos_anakena/models/reclamos_models/reclamo.dart';

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
    return '0';
  }
}

Future<List<Reclamo>> obtenerReclamos() async {
  // Conectarse a la base de datos MongoDB

  var env = dotenv.get('MONGODB_URI');
  var db = await Db.create(env.toString());

  await db.open();

  // Obtener la colección de reclamos
  var reclamosData = await db.collection('reclamos').find().toList();

  await db.close();

  // Convertir los documentos en reclamos
  List<Reclamo> reclamos = reclamosData.map((data) {
    return Reclamo(
      data['_id'],
      data['fechaReclamo'],
      data['fechaIngreso'],
      data['tipo'],
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

Future<String> modificarReclamo(String id, String nuevoMotivo, String nuevaResolucion,String estado) async {
  var env = dotenv.get('MONGODB_URI');
  var db = await Db.create(env.toString());

  await db.open();

  var reclamosCollection = db.collection('reclamos');

  var result = await reclamosCollection.updateOne(
    where.eq('_id', ObjectId.parse(id)),
    modify.set('motivo', nuevoMotivo).set('resolucion', nuevaResolucion).set("estado", estado),
  );

  await db.close();


 if (result.ok == 1) {
    return 'Reclamo modificado';
  } else {
    return 'Error al modificar reclamo';
  }
}

