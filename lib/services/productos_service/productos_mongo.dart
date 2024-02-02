

import 'package:mongo_dart/mongo_dart.dart';
import 'package:reclamos_anakena/barrels.dart';
import 'package:reclamos_anakena/models/productos_models/productos.dart';

Future<String> ingresarProducto(Productos producto) async {
  String env = dotenv.get('MONGODB_URI');
  var db = await Db.create(env);
  await db.open();
  var productoCollection = db.collection('productos');
  WriteResult result = await productoCollection.insertOne(producto.toMap());
  await db.close();
  if (result.ok == 1) {
    return result.id.toHexString();
  } else {
    return '0';
  }
}
Future<List<Productos>> obtenerProductos() async {
  var env = dotenv.get('MONGODB_URI');
  var db = await Db.create(env.toString());
  await db.open();
  var productosData = await db.collection('productos').find().toList();
  await db.close();
  List<Productos> productos = productosData.map((data) {
    return Productos(
      data['_id'],
      data['producto'],
    );
  }).toList();
  return productos;
}
