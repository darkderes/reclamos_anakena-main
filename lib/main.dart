import 'package:reclamos_anakena/barrels.dart';


Future<String> getInitialRoute() async {
  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getString('nombre') != null;
  return isLoggedIn ? '/home' : '/';
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URI']!,
    anonKey: dotenv.env['SUPABASE_KEY']!,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getInitialRoute(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        } else {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<Myprovider>(
                create: (context) => Myprovider(),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme(selectedColor: 1).getTheme(),
              initialRoute: snapshot.data,
              routes: {
                "/": (context) => const Login(),
                "/home": (context) => const AdminReclamos(),
                "/add_reclamos": (context) => const AddReclamos(),
                "/details_reclamos": (context) => DetailsReclamos(
                    reclamo: ModalRoute.of(context)!.settings.arguments as Reclamo),
                "/galery_screen": (context) {
                  final String miDato =
                      ModalRoute.of(context)!.settings.arguments as String;
                  return GaleryScreen(proceso: miDato);
                },
                "/galery_files": (context) {
                  final String miDato =
                      ModalRoute.of(context)!.settings.arguments as String;
                  return GalleryFiles(proceso: miDato);
                },
              },
            ),
          );
        }
      },
    );
  }
}