import 'package:flutter/material.dart';
import 'package:reclamos_anakena/models/reclamos_models/reclamo.dart';
import 'package:reclamos_anakena/providers/provider_reclamos.dart';
import 'package:reclamos_anakena/utils/sent_mails.dart';

Future<String> handleReclamoLogic(BuildContext context, Myprovider myProvider, Reclamo nuevoReclamo) async {
  if (myProvider.reclamoId == "") {
    await myProvider.addReclamo(nuevoReclamo);
    sendEmail(nuevoReclamo);
  } else {
    await myProvider.updateReclamo(myProvider.reclamoId, nuevoReclamo);
  }

  String resp = myProvider.reclamoId == "0"
      ? "Ocurrio un error"
      : "Reclamo guardado correctamente";

  
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(resp),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Aceptar'),
          ),
        ],
      );
    },
  );
  return resp;

}