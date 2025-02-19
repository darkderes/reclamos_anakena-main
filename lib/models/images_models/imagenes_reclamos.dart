import 'package:mongo_dart/mongo_dart.dart';

class Imagenes {
  ObjectId? objectid;
  String seccion;
  String url;


  Imagenes(this.objectid,this.seccion, this.url);

  Map<String, dynamic> toMap() {
    return {
      '_id': objectid,
      'seccion': seccion,
      'url': url,
    };
  }
  // crear fromMap
  factory Imagenes.fromMap(Map<String, dynamic> map) {
    return Imagenes(
      map['_id'],
      map['seccion'],
      map['url']
    );
  }
}
