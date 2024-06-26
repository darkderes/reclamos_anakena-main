import 'package:reclamos_anakena/barrels.dart';
import 'package:intl/intl.dart';

class AdminReclamos extends StatelessWidget {
  const AdminReclamos({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyHomePage(title: 'Administrar Reclamos');
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController searchController = TextEditingController();
  bool isSearchEmpty = true;

  @override
  void initState() {
    super.initState();
    FullScreenWindow.setFullScreen(true);
    searchController.addListener(() {
      setState(() {
        isSearchEmpty = searchController.text.isEmpty;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.minimize),
            tooltip: 'Minimizar',
            onPressed: () async {
              if (Platform.isWindows) {
                final hWnd = GetForegroundWindow();
                ShowWindow(hWnd, SHOW_WINDOW_CMD.SW_MINIMIZE);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            tooltip: 'Cerrar App',
            onPressed: () {
              if (Platform.isWindows) {
                ExitProcess(0);
              }
              SystemNavigator.pop();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(30.0),
              child: LogoAnakena(),
            ),
            Consumer<Myprovider>(
              builder: (context, myProvider, child) {
                if (myProvider.reclamos.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  var filterReclamos = myProvider.reclamos
                      .where((reclamo) =>
                          reclamo.embarque.toLowerCase().contains(
                              searchController.text.toLowerCase()) ||
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
                                                    fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  leading: reclamo.estado == "Creado"
                                      ? const Icon(Icons.assignment)
                                      : reclamo.estado == "Asignado"
                                          ? const Icon(Icons.assignment_turned_in)
                                          : const Icon(Icons.assignment_turned_in_outlined),
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
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/add_reclamos");
        },
        tooltip: 'Agregar Reclamo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
