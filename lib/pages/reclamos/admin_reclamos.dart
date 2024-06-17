import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fullscreen_window/fullscreen_window.dart';
import 'package:intl/intl.dart';
import 'package:reclamos_anakena/barrels.dart';
import 'package:reclamos_anakena/utils/sent_mails.dart';
import 'package:win32/win32.dart';

class AdminReclamos extends StatelessWidget {
  const AdminReclamos({super.key});

  // This widget is the root of your application.
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
  @override
  void initState() {
    super.initState();
    FullScreenWindow.setFullScreen(true);
  }

  @override
  Widget build(BuildContext context) {
    FullScreenWindow.setFullScreen(true);
    setState(() {});

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        // backgroundColor: Colors.brown,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.minimize),
            tooltip: 'Minimizar',
            onPressed: () async {
              // salir de app
              if (Platform.isWindows) {
                final hWnd = GetForegroundWindow();
                ShowWindow(hWnd, SHOW_WINDOW_CMD.SW_MINIMIZE);
              }
              // SystemNavigator.pop();
            },
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            tooltip: 'Cerrar App',
            onPressed: () {
              // salir de app
              if (Platform.isWindows) {
                ExitProcess(0);
              }
              SystemNavigator.pop();
            },
          ),
        ],
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
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
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListView.builder(
                        itemCount: myProvider.reclamos.length,
                        itemBuilder: (context, index) {
                          var reclamo = myProvider.reclamos[index];
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
                                      "Fecha Ingreso  ${DateFormat('dd-MM-yyyy').format(DateTime.parse(reclamo.fechaReclamo))}"),
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
                              // como puedo poner otro icono en el leading
                              leading: reclamo.estado == "Creado"
                                  ? const Icon(Icons.assignment)
                                  : reclamo.estado == "Asignado"
                                      ? const Icon(Icons.assignment_turned_in)
                                      : const Icon(
                                          Icons.assignment_turned_in_outlined),

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
          setState(() {});
        },
        tooltip: 'Agregar Reclamo',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
