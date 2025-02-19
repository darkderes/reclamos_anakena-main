import 'package:mongo_dart/mongo_dart.dart';
import 'package:reclamos_anakena/barrels.dart';

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
      data['producto'],
      data['observacionMotivo'],
      data['tipoReclamo'],
      data['otroTipo'],
      data['personal'],
      data['resolucion'],
      data['resolucionComercial'] ?? '',
      data['estado'],
       (data['imagenes'] as List<dynamic>?)
          ?.map((item) => Imagenes.fromMap(item))
          .toList() ?? [],
      (data['archivos'] as List<dynamic>?)
          ?.map((item) => Archivos.fromMap(item))
          .toList() ?? [],
    );
  }).toList();

  return reclamos;
}

// crear un modificar reclamo con el id y el objeto de reclamo

Future<String> modificarReclamos (String id, Reclamo reclamo) async {
  var env = dotenv.get('MONGODB_URI');
  var db = await Db.create(env.toString());

  await db.open();

  var reclamosCollection = db.collection('reclamos');

  var result = await reclamosCollection.updateOne(
    where.eq('_id', ObjectId.parse(id)),
    modify.set('fechaReclamo', reclamo.fechaReclamo)
        .set('fechaIngreso', reclamo.fechaIngreso)
        .set('tipo', reclamo.tipo)
        .set('nombreCliente', reclamo.nombreCliente)
        .set('embarque', reclamo.embarque)
        .set('comercial', reclamo.comercial)
        .set('motivo', reclamo.motivo)
        .set('producto', reclamo.producto)
        .set('observacionMotivo', reclamo.observacionMotivo)
        .set('tipoReclamo', reclamo.tipoReclamo)
        .set('otroTipo', reclamo.otroTipo)
        .set('personal', reclamo.personal)
        .set('resolucion', reclamo.resolucion)
        .set('resolucionComercial', reclamo.resolucionComercial)
        .set('estado', reclamo.estado),
  );

  await db.close();

  if (result.ok == 1) {
    return 'Reclamo actualizado correctamente';
  } else {
    return 'Error al modificar reclamo';
  }
}
