import 'package:mongo_dart/mongo_dart.dart';

class Imagenes {
  ObjectId? objectid;
  String seccion;
  String url;
  String idReclamo;

  Imagenes(this.objectid,this.seccion, this.url, this.idReclamo);

  Map<String, dynamic> toMap() {
    return {
      '_id': objectid,
      'seccion': seccion,
      'url': url,
      'idReclamo': idReclamo,
    };
  }
  // crear fromMap
  factory Imagenes.fromMap(Map<String, dynamic> map) {
    return Imagenes(
      map['_id'],
      map['seccion'],
      map['url'],
      map['idReclamo'],
    );
  }
}
