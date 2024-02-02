import 'package:mongo_dart/mongo_dart.dart';

class Productos {
  ObjectId? objectId;
   String producto;
   Productos(this.objectId, this.producto);
Map<String, dynamic> toMap() {
    return {
      '_id': objectId,
      'producto': producto,
    };
  }
}
