import 'package:intl/intl.dart';
import 'package:reclamos_anakena/barrels.dart';

class ListaReclamos extends StatelessWidget {
  const ListaReclamos({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Consumer<Myprovider>(
      builder: (context, myProvider, child) {
        if (myProvider.reclamos.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          var filterReclamos = myProvider.reclamos
              .where((reclamo) =>
                  reclamo.embarque
                      .toLowerCase()
                      .contains(searchController.text.toLowerCase()) ||
                  reclamo.producto
                      .toLowerCase()
                      .contains(searchController.text.toLowerCase()))
              .toList();
          return Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 130.0, right: 130.0, top: 16.0, bottom: 8),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: 'Buscar por N° embarque o Producto',
                      suffixIcon: searchController.text.isEmpty
                          ? const Icon(Icons.search)
                          : IconButton(
                              onPressed: () {
                                searchController.clear();
                              },
                              icon: const Icon(Icons.clear),
                            ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filterReclamos.length,
                    itemBuilder: (context, index) {
                      var reclamo = filterReclamos[index];
                      return Card(
                        child: ListTile(
                          title: Text(
                              "${reclamo.nombreCliente} - Comercial: ${reclamo.comercial}",
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          subtitle: Text(
                              "N° Embarque: ${reclamo.embarque}  - Tipo : ${reclamo.tipo} - Producto: ${reclamo.producto}"),
                          trailing: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                  "Fecha Reclamo ${DateFormat('dd-MM-yyyy').format(DateTime.parse(reclamo.fechaReclamo))}"),
                              Text(
                                  "Fecha Ingreso  ${DateFormat('dd-MM-yyyy').format(DateTime.parse(reclamo.fechaIngreso))}"),
                              Text(
                                reclamo.estado,
                                style: reclamo.estado == "Creado"
                                    ? const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold)
                                    : reclamo.estado == "Asignado"
                                        ? const TextStyle(
                                            color: Color.fromARGB(
                                                255, 139, 86, 6),
                                            fontWeight: FontWeight.bold)
                                        : const TextStyle(
                                            color: Colors.red,
                                            fontWeight:
                                                FontWeight.bold),
                              ),
                            ],
                          ),
                          leading: reclamo.estado == "Creado"
                              ? const Icon(Icons.assignment)
                              : reclamo.estado == "Asignado"
                                  ? const Icon(
                                      Icons.assignment_turned_in)
                                  : const Icon(Icons
                                      .assignment_turned_in_outlined),
                          onTap: () {
                            Navigator.pushNamed(
                                context, "/details_reclamos",
                                arguments: reclamo);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
