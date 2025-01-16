import 'package:reclamos_anakena/barrels.dart';

class ButtonLogin extends StatelessWidget {
  const ButtonLogin({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) : _formKey = formKey, _emailController = emailController, _passwordController = passwordController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          // Llamar a la función login
          await login(
              context, _emailController.text, _passwordController.text);
     
        }
      },
      child: const Text('Iniciar sesión'),
    );
  }
}

