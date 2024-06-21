import 'package:reclamos_anakena/barrels.dart';

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
  Future<String> updateReclamo(String id,Reclamo reclamo) async {
    String res = await modificarReclamos(id, reclamo);
    reclamos = await obtenerReclamos();
    notifyListeners();
    return res;
  }
}
 // notificar obtenerReclamos
  