import 'package:mongo_dart/mongo_dart.dart';

class Motivos {
  ObjectId? objectId;
  String motivo;

  Motivos(this.objectId, this.motivo);

  Map<String, dynamic> toMap() {
    return {
      '_id': objectId,
      'motivo': motivo,
    };
  }
}
