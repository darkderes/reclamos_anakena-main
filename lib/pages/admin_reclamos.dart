import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fullscreen_window/fullscreen_window.dart';
import 'package:provider/provider.dart';
import 'package:win32/win32.dart';
import '../services/provider_reclamos.dart';

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
                ShowWindow(hWnd, SW_MINIMIZE);
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
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Center(
                child: Image.asset(
                  'assets/images/logoAnakena.png',
                ), // Reemplaza 'assets/logo.png' con la ruta de tu imagen de logo
              ),
            ),
            Consumer<Myprovider>(
              builder: (context, myProvider, child) {
                if (myProvider.reclamos.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                
                
                 else {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListView.builder(
                        itemCount: myProvider.reclamos.length,
                        itemBuilder: (context, index) {
                          var reclamo = myProvider.reclamos[index];
                          return Card(
                            child: ListTile(
                              title: Text(reclamo.nombreCliente,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text(
                                  "N° Embarque: ${reclamo.embarque}  - Tipo Reclamo: ${reclamo.tipoReclamo}"),
                              trailing: Text(reclamo.estado),
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
