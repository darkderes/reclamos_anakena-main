import 'package:mongo_dart/mongo_dart.dart';
import 'package:reclamos_anakena/barrels.dart';

class Myprovider with ChangeNotifier {
  List<Reclamo> reclamos = [];
  bool isLoading = false;
  Reclamo reclamo = Reclamo(
    null,
    DateTime.now().toString(),
    DateTime.now(),
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    [],
    [],
  );
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
   Future<Reclamo> addReclamo(Reclamo reclamo) async {
    reclamo = await insertarReclamo(reclamo);
    reclamos = await obtenerReclamos();
    notifyListeners();
    return reclamo;
  }
  Future<String> updateReclamo(Reclamo reclamo) async {
    String res = await modificarReclamos(reclamo);
    reclamos = await obtenerReclamos();
    reclamo = reclamos.firstWhere((element) => element.objectId == reclamo.objectId);
    notifyListeners();
    return res;
  }
  // llamar a mi servicio de deleteUrlImage
  Future<void> deleteUrlImages(String idReclamo, String url) async {
    await deleteUrlImage(idReclamo, url);
    reclamos = await obtenerReclamos();
    reclamo = reclamos.firstWhere((element) => element.objectId == reclamo.objectId);
    notifyListeners();
  }
  // llamar a mi servicio de deleteUrlArchivo
  Future<void> deleteUrlArchivos(String idReclamo, String url) async {
    await deleteUrlArchivo(idReclamo, url);
    reclamos = await obtenerReclamos();
    reclamo = reclamos.firstWhere((element) => element.objectId == reclamo.objectId);
    notifyListeners();
  }
  // llamar a mi servicio de obtenerReclamos por ID
  Future<Reclamo> getReclamoById(ObjectId id) async {
    reclamo = await obtenerReclamoPorId(id);
    notifyListeners();
    return reclamo; 
   
  }
}
 // notificar obtenerReclamos
  