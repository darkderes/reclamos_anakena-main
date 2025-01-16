
class Usuarios {

    String nombre = '';
    String email = '';
    String rol = '';
    String img = '';

  Usuarios( this.nombre, this.email, this.rol, this.img);

  Usuarios.fromJsonMap(Map<String, dynamic> json) {
    nombre = json['nombre'];
    email = json['email'];
    rol = json['rol'];
    img = json['img'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nombre'] = nombre;
    data['email'] = email;
    data['rol'] = rol;
    data['img'] = img;
    return data;
  }
  

}