import 'package:reclamos_anakena/barrels.dart';

class TxtCorreo extends StatelessWidget {
  const TxtCorreo({
    super.key,
    required TextEditingController emailController,
  }) : _emailController = emailController;

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _emailController,
      maxLength: 25,
      style: const TextStyle(
        letterSpacing: 2,
        color: Colors.brown,
        fontSize: 18,
      ),
      decoration: const InputDecoration(
        labelText: 'Correo electrónico',
      ),
      validator: (value) {
        if (value!.isEmpty || !value.contains('@')) {
          return 'Por favor ingrese su correo electrónico';
        }
        return null;
      },
    );
  }
}