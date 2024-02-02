import 'package:mongo_dart/mongo_dart.dart';
import 'package:reclamos_anakena/barrels.dart';
import 'package:reclamos_anakena/models/motivos_models/motivos.dart';

Future<String> ingresarMotivo(Motivos motivo) async {
  String env = dotenv.get('MONGODB_URI');
  var db = await Db.create(env);
  await db.open();
  var motivoCollection = db.collection('motivos');
  WriteResult result = await motivoCollection.insertOne(motivo.toMap());
  await db.close();
  if (result.ok == 1) {
    return result.id.toHexString();
  } else {
    return '0';
  }
}

Future<List<Motivos>> obtenerMotivos() async {
  var env = dotenv.get('MONGODB_URI');
  var db = await Db.create(env.toString());
  await db.open();
  var motivosData = await db.collection('motivos').find().toList();
  await db.close();
  List<Motivos> motivos = motivosData.map((data) {
    return Motivos(
      data['_id'],
      data['motivo'],
    );
  }).toList();
  return motivos;
}
