import 'package:mongo_dart/mongo_dart.dart';
import 'package:reclamos_anakena/barrels.dart';

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
  String resolucionComercial;
  String estado;
  List<Imagenes> imagenes = [];
  List<Archivos> archivos = [];

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
      this.resolucionComercial,
      this.estado,
      this.imagenes,
      this.archivos);

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
      'resolucionComercial': resolucionComercial ?? '',
      'estado': estado,
      'imagenes': imagenes.map((e) => e.toMap()).toList(),
      'archivos': archivos.map((e) => e.toMap()).toList(),
    };
  }

  factory Reclamo.fromMap(Map<String, dynamic> data) {
    return Reclamo(
      data['_id'],
      data['fechaReclamo'],
      data['fechaIngreso'],
      data['tipo'],
      data['nombreCliente'],
      data['embarque'],
      data['comercial'],
      data['motivo'],
      data['producto'],
      data['observacionMotivo'],
      data['tipoReclamo'],
      data['otroTipo'],
      data['personal'],
      data['resolucion'],
      data['resolucionComercial'] ?? '',
      data['estado'],
      (data['imagenes'] as List<dynamic>?)
              ?.map((item) => Imagenes.fromMap(item))
              .toList() ??
          [],
      (data['archivos'] as List<dynamic>?)
              ?.map((item) => Archivos.fromMap(item))
              .toList() ??
          [],
    );
  }
}
