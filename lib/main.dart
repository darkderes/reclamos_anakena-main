import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reclamos_anakena/pages/add_reclamos.dart';
import 'package:reclamos_anakena/pages/admin_reclamos.dart';
import 'package:reclamos_anakena/services/provider_reclamos.dart';
import 'package:reclamos_anakena/theme/app_theme.dart';


void main()  async{
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
    
         },
      ),
    );
  }
}

