import 'package:reclamos_anakena/barrels.dart';
import 'package:reclamos_anakena/pages/login/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


void main() async {
  await dotenv.load(fileName: "assets/.env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URI']!,
    anonKey: dotenv.env['SUPABASE_KEY']!,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
   
      ChangeNotifierProvider<Myprovider>(
        create: (context) => Myprovider(),
      ),       
    ],
      
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme(selectedColor: 1).getTheme(),
        initialRoute: "/",
        routes: {
          "/": (context) =>  const Login(),
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
}
