import 'package:flutter/material.dart';

class TxtPassword extends StatefulWidget {
  final TextEditingController controller;


  const TxtPassword({
    super.key,
    required this.controller
  });

  @override
  TxtPasswordState createState() => TxtPasswordState();
}

class TxtPasswordState extends State<TxtPassword> {
  bool _isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _isPasswordHidden,
      decoration: InputDecoration(
        labelText: 'Contraseña',
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordHidden ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _isPasswordHidden = !_isPasswordHidden;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingrese su contraseña';
        }
        return null;
      },
    );
  }
}