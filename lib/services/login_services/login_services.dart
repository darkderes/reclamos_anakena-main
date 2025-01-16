import 'package:reclamos_anakena/barrels.dart';
import 'package:reclamos_anakena/models/usuarios_models/usuarios.dart';
import 'package:reclamos_anakena/services/login_services/login_mongo.dart';

Future login(BuildContext context, email, String password) async {
  final supabase = Supabase.instance.client;

  try {
    final AuthResponse res = await supabase.auth.signInWithPassword(
      password: password,
      email: email,
    );

    final Session? session = res.session;
    final User? user = res.user;

    if (session != null && user != null) {
      Usuarios? userMongo = await loginMongo(email);
      if (userMongo != null) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', email);
        prefs.setString('nombre', userMongo.nombre);
        prefs.setString('img', userMongo.img);
        prefs.setString('rol', userMongo.rol);
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const DialogCustom(
              title: 'Error',
              resp: 'Error en MongoDb al buscar el usuario',
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const DialogCustom(
            title: 'Error',
            resp: 'No se pudo iniciar sesión',
          );
        },
      );
    }
  } catch (e) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogCustom(
          title: 'Error',
          resp: e.toString(),
        );
      },
    );
  }
}

Future<void> signOut(BuildContext context) async {
  final supabase = Supabase.instance.client;
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await supabase.auth.signOut();
  await prefs.clear();
  Navigator.pushReplacementNamed(context, '/');
}
