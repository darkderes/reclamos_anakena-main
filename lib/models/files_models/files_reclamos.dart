import 'package:mongo_dart/mongo_dart.dart';

class Archivos {
  ObjectId? objectid;
  String seccion;
  String url;
  String etiqueta;
  String idReclamo;

  Archivos(
      this.objectid, this.seccion, this.url, this.etiqueta, this.idReclamo);


  Map<String, dynamic> toMap() {
    return {
      '_id': objectid,
      'seccion': seccion,
      'url': url,
      'etiqueta': etiqueta,
      'idReclamo': idReclamo,
    };
  }
  // fromMap
  factory Archivos.fromMap(Map<String, dynamic> map) {
    return Archivos(
      map['_id'],
      map['seccion'],
      map['url'],
      map['etiqueta'],
      map['idReclamo'],
    );
  }
}
