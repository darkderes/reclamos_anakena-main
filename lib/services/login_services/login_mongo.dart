

import 'package:mongo_dart/mongo_dart.dart';
import 'package:reclamos_anakena/barrels.dart';
import 'package:reclamos_anakena/models/usuarios_models/usuarios.dart';

Future<Usuarios?> loginMongo(String email) async {
  try {
    var env = dotenv.get('MONGODB_URI');
    var db = await Db.create(env.toString());

    await db.open();

    var usersCollection = db.collection('usuarios');

    var result = await usersCollection.findOne(where.eq('email', email));

    await db.close();

    if (result != null) {
      return Usuarios.fromJsonMap(result);
    } else {
      return null; // Retorna null si no se encuentra el usuario
    }
  } catch (e) {
    print('Error al conectar a MongoDB: $e');
    return null; // Retorna null en caso de error
  }
}