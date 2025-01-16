import 'package:reclamos_anakena/barrels.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/home');
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
