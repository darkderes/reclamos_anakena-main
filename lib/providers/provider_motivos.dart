import 'package:reclamos_anakena/barrels.dart';
import 'package:reclamos_anakena/models/motivos_models/motivos.dart';
import 'package:reclamos_anakena/services/motivos_service/motivos_mongo.dart';

class ProviderMotivo with ChangeNotifier {
  List<Motivos> motivos = [];
  String motivoId = '';
  ProviderMotivo() {
    obtenerMotivos().then((value) {
    
      notifyListeners();
      motivos = value;
      motivos.sort((a, b) => a.motivo!.compareTo(b.motivo!));

      notifyListeners();
    });
  }

  Future<String> addMotivo(Motivos motivo) async {
    motivoId = await ingresarMotivo(motivo);
    motivos = await obtenerMotivos();
    notifyListeners();
    return motivoId;
  }
}
