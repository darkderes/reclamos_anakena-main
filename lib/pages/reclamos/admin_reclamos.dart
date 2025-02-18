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
  String? userRole;

  @override
  void initState() {
    super.initState();
    FullScreenWindow.setFullScreen(true);
    searchController.addListener(() {
      setState(() {
        isSearchEmpty = searchController.text.isEmpty;
      });
    });
    _loadUserRole();
  }

  Future<void> _loadUserRole() async {
    userRole = await getUserRole();
    setState(() {});
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
        automaticallyImplyLeading: false,
        title: Text(widget.title),
        actions: const <Widget>[UserData(), IconMinimizar(), IconCerrar()],
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
          if (userRole == 'Comercial') {
            Navigator.pushNamed(context, "/add_reclamos");
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const DialogCustom(
                  title: 'Permiso denegado',
                  resp: 'No tienes permisos para agregar reclamos',
                );
              },
            );
          }
        },
        tooltip: 'Agregar Reclamo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
