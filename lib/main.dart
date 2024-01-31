import 'package:reclamos_anakena/barrels.dart';

void main() async {
  await dotenv.load(fileName: "assets/.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Myprovider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme(selectedColor: 1).getTheme(),
        initialRoute: "/",
        routes: {
          "/": (context) => const AdminReclamos(),
          "/add_reclamos": (context) => const AddReclamos(),
          "/details_reclamos": (context) => DetailsReclamos(
              reclamo: ModalRoute.of(context)!.settings.arguments as Reclamo),
          "/galery_screen": (context) {
            final String miDato =
                ModalRoute.of(context)!.settings.arguments as String;
            return GaleryScreen(proceso: miDato);
          },
        },
      ),
    );
  }
}
