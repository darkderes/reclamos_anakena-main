import 'package:flutter/material.dart';

class DialogCustom extends StatelessWidget {
  const DialogCustom({
    super.key,
    required this.resp,
    required this.title,
  });

  final String resp;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:  Text(title),
      content: Text(resp,style: const TextStyle(fontSize: 15),),
      actions: <Widget>[
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}