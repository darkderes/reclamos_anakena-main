class Imagenes {

  String seccion;
  String url;


  Imagenes(this.seccion, this.url);

  Map<String, dynamic> toMap() {
    return {
      'seccion': seccion,
      'url': url,
    };
  }
  // crear fromMap
  factory Imagenes.fromMap(Map<String, dynamic> map) {
    return Imagenes(
      map['seccion'],
      map['url']
    );
  }
}
