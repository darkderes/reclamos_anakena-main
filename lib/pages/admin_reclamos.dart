import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar: AppBar(

      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: Text(widget.title),
      // ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Center(
                child: Image.asset('assets/images/logoAnakena.png',
                    
                ), // Reemplaza 'assets/logo.png' con la ruta de tu imagen de logo
              ),
            ),
               const Text(
                'Listado de Reclamos',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.brown)
              ),
            Consumer<Myprovider>(
              builder: (context, myProvider, child) {
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
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            subtitle: Text(
                                "N° Embarque: ${reclamo.embarque}  - Tipo Reclamo: ${reclamo.tipoReclamo}"),
                            trailing: Text(reclamo.estado),
                            onTap: () {
                              Navigator.pushNamed(context, "/details_reclamos",
                                  arguments: reclamo);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                );
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
