import 'package:mongo_dart/mongo_dart.dart';

class Imagenes {
   ObjectId? objectid ;
   String url;
   String idReclamo;

  Imagenes(this.objectid, this.url, this.idReclamo);

  Map<String, dynamic> toMap() {
    return {
      '_id': objectid,
      'url': url,
      'idReclamo': idReclamo,
    };
  }

}