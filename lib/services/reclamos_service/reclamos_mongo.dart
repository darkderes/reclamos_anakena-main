import 'package:mongo_dart/mongo_dart.dart';
import 'package:reclamos_anakena/barrels.dart';

Future<Reclamo> insertarReclamo(Reclamo reclamo) async {
  String env = dotenv.get('MONGODB_URI');
  var db = await Db.create(env);
  await db.open();
  var reclamosCollection = db.collection('reclamos');
  WriteResult result = await reclamosCollection.insertOne(reclamo.toMap());
  if (result.ok == 1) {
    var insertedId = result.id;
    var insertedReclamo = await reclamosCollection.findOne(where.id(insertedId));
    await db.close();
    return Reclamo.fromMap(insertedReclamo ?? {});
  } else {
    await db.close();
    throw Exception('Error al insertar reclamo');
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

Future<String> modificarReclamos (Reclamo reclamo) async {
  var env = dotenv.get('MONGODB_URI');
  var db = await Db.create(env.toString());

  await db.open();

  var reclamosCollection = db.collection('reclamos');

  var result = await reclamosCollection.updateOne(
    where.eq('_id', reclamo.objectId),
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
        .set('estado', reclamo.estado)
        .set('imagenes', reclamo.imagenes.map((e) => e.toMap()).toList())
        .set('archivos', reclamo.archivos.map((e) => e.toMap()).toList())

  );

  await db.close();

  if (result.ok == 1) {
    return 'Reclamo actualizado correctamente';
  } else {
    return 'Error al modificar reclamo';
  }
}

// como para eliminar un imagen de un reclamo

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
// como para eliminar un archivo de un reclamo

Future<void> deleteUrlArchivo(String idReclamo, String url) async {
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
      modify.pull('archivos', {'url': url}),
    );

    if (result.isSuccess) {
      debugPrint('✅ Archivo eliminado correctamente del reclamo');
    } else {
      debugPrint('⚠️ Error al eliminar archivo del reclamo');
    }
  } catch (e) {
    debugPrint('❌ Excepción al eliminar el archivo: $e');
  } finally {
    await db?.close();
  }

}
// funcion para traer un reclamo por su ID

Future<Reclamo> obtenerReclamoPorId(ObjectId id) async {
  var env = dotenv.get('MONGODB_URI');
  var db = await Db.create(env);
  await db.open();
  var reclamosCollection = db.collection('reclamos');
  var reclamo = await reclamosCollection.findOne(where.id(id));
  await db.close();
  return Reclamo.fromMap(reclamo ?? {});
}
