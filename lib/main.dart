import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:reclamos_anakena/models/reclamo.dart';
import 'package:reclamos_anakena/pages/Images/gallery_screen.dart';
import 'package:reclamos_anakena/pages/add_reclamos.dart';
import 'package:reclamos_anakena/pages/admin_reclamos.dart';
import 'package:reclamos_anakena/pages/details_reclamos.dart';
import 'package:reclamos_anakena/services/provider_reclamos.dart';
import 'package:reclamos_anakena/theme/app_theme.dart';


void main()  async{
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
           "/details_reclamos": (context) => DetailsReclamos(reclamo: ModalRoute.of(context)!.settings.arguments as Reclamo),
         "/galery_screen": (context) {
  final String miDato = ModalRoute.of(context)!.settings.arguments as String;
  return GaleryScreen(proceso: miDato);
},
    
         },
      ),
    );
  }
}

