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
  String producto = '';
  String observacionMotivo = '';
  String tipoReclamo;
  String otroTipo;
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
      this.producto,
      this.observacionMotivo,
      this.tipoReclamo,
      this.otroTipo,
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
      'producto': producto,
      'observacionMotivo': observacionMotivo,
      'tipoReclamo': tipoReclamo,
      'otroTipo': otroTipo,
      'personal': personal,
      'resolucion': resolucion,
      'estado': estado,
    };
  }
}
