import 'package:reclamos_anakena/barrels.dart';

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
        actions:  const <Widget>[UserData(), IconMinimizar(), IconCerrar()],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(30.0),
              child: LogoAnakena(),
            ),
            ListaReclamos(searchController: searchController),
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