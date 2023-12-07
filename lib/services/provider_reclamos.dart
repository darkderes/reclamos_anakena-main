import 'package:flutter/foundation.dart';
import 'package:reclamos_anakena/services/reclamos_mongo.dart';
import '../models/reclamo.dart';

class Myprovider with ChangeNotifier {
  List<Reclamo> reclamos = [];
  String reclamoId = '';
  Myprovider() {
    obtenerReclamos().then((value) {
      reclamos = value;
       reclamos.sort((a, b) => a.fechaReclamo.compareTo(b.fechaReclamo));
      notifyListeners();
    });
  }
 // List<Reclamo> get reclamos => _reclamos;

  void addReclamo(Reclamo reclamo) async {
    reclamoId = await insertarReclamo(reclamo);
    reclamos = await obtenerReclamos();
    reclamos.sort((a, b) => a.fechaReclamo.compareTo(b.fechaReclamo));
    notifyListeners();
  }
  Future<String> updateReclamo(String id,String motivo,String resolucion) async {
    String res = await modificarReclamo(id, motivo,resolucion);
    reclamos = await obtenerReclamos();
    reclamos.sort((a, b) => a.fechaReclamo.compareTo(b.fechaReclamo));
    notifyListeners();
    return res;
  }
}
 // notificar obtenerReclamos
  