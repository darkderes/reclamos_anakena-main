
import 'package:reclamos_anakena/barrels.dart';
import 'package:reclamos_anakena/models/productos_models/productos.dart';
import 'package:reclamos_anakena/services/productos_service/productos_mongo.dart';

class ProductoProvider with ChangeNotifier {
  List<Productos> productos = [];
  String productoId = '';
  ProductoProvider() {
    obtenerProductos().then((value) {
      notifyListeners();
      productos = value;
      productos.sort((a, b) => a.producto.compareTo(b.producto));
      notifyListeners();
    });
  }

  Future<String> addProducto(Productos producto) async {
    productoId = await ingresarProducto(producto);
    productos = await obtenerProductos();
    notifyListeners();
    return productoId;
  }
}
