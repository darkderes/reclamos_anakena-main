class Archivos {

  String seccion;
  String url;
  String etiqueta;


  Archivos(
      this.seccion, this.url, this.etiqueta);


  Map<String, dynamic> toMap() {
    return {
      'seccion': seccion,
      'url': url,
      'etiqueta': etiqueta,
    };
  }
  // fromMap
  factory Archivos.fromMap(Map<String, dynamic> map) {
    return Archivos(
      map['seccion'],
      map['url'],
      map['etiqueta'],
    );
  }
}
