import 'package:mongo_dart/mongo_dart.dart';
import 'package:reclamos_anakena/models/reclamo.dart';



void insertarReclamo(Reclamo reclamo) async {
  var db = await Db.create('mongodb+srv://jdarderes:Jadv0106@clusteranakena.eckzerk.mongodb.net/reclamos?retryWrites=true&w=majority');
  await db.open();
  var reclamosCollection = db.collection('reclamos');
  WriteResult result = await reclamosCollection.insertOne(reclamo.toMap());
  await db.close();
  if (result.ok == 1) {
    print('Reclamo insertado correctamente');
  } else {
    print('Error al insertar reclamo');
  }

}
Future<List<Reclamo>> obtenerReclamos() async {
  // Conectarse a la base de datos MongoDB
  var db = await Db.create('mongodb+srv://jdarderes:Jadv0106@clusteranakena.eckzerk.mongodb.net/reclamos?retryWrites=true&w=majority');
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
      data['personal'],
      data['resolucion'],
      data['estado'],
    );
  }).toList();

  return reclamos;
}


