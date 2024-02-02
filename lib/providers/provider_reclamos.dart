import 'package:flutter/foundation.dart';
import 'package:reclamos_anakena/services/reclamos_service/reclamos_mongo.dart';
import '../models/reclamos_models/reclamo.dart';

class Myprovider with ChangeNotifier {
  List<Reclamo> reclamos = [];
  bool isLoading = false;
  String reclamoId = '';
  Myprovider() {
    obtenerReclamos().then((value) {
      isLoading = true;
      notifyListeners();
      reclamos = value;
       reclamos.sort((a, b) => b.fechaIngreso.compareTo(a.fechaIngreso));
      isLoading = false;
      notifyListeners();
    });
  }
   Future<String> addReclamo(Reclamo reclamo) async {
    reclamoId = await insertarReclamo(reclamo);
    reclamos = await obtenerReclamos();
    notifyListeners();
    return reclamoId;
  }
  Future<String> updateReclamo(String id,String motivo,String resolucion,String estado) async {
    String res = await modificarReclamo(id, motivo,resolucion,estado);
    reclamos = await obtenerReclamos();
    notifyListeners();
    return res;
  }
}
 // notificar obtenerReclamos
  