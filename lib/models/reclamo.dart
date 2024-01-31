import 'package:mongo_dart/mongo_dart.dart';

class Reclamo {
  ObjectId? objectId;
  late String fechaReclamo;
  String fechaIngreso = DateTime.now().toString();
  String tipo;
  String nombreCliente;
  String embarque;
  String comercial;
  String motivo;
  String observacionMotivo = '';
  String tipoReclamo;
  String personal;
  String resolucion;
  String estado;

  Reclamo(
      this.objectId,
      this.fechaReclamo,
      fechaIngreso,
      this.tipo,
      this.nombreCliente,
      this.embarque,
      this.comercial,
      this.motivo,
      this.tipoReclamo,
      this.personal,
      this.resolucion,
      this.estado);

  Map<String, dynamic> toMap() {
    return {
      '_id': objectId,
      'fechaReclamo': fechaReclamo,
      'fechaIngreso': fechaIngreso,
      'tipo': tipo,
      'nombreCliente': nombreCliente,
      'embarque': embarque,
      'comercial': comercial,
      'motivo': motivo,
      'tipoReclamo': tipoReclamo,
      'personal': personal,
      'resolucion': resolucion,
      'estado': estado,
    };
  }
}
