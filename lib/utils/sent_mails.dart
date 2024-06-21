import 'package:reclamos_anakena/barrels.dart';

void sendEmail(Reclamo nuevoReclamo) async {
  String username = 'alerta@anakena.cl';
  String password = 'Paine164';

  // Crear el servidor de correo electrónico para office365
    final smtpServer = SmtpServer(
    'smtp.office365.com',
    port: 587,
    ssl: false,
    ignoreBadCertificate: true,
    allowInsecure: true,
    username: username,
    password: password,
  );

  // Crear el mensaje de correo electrónico
  final message = Message()
    ..from = Address(username, 'Anakena Alerta')
    // tengo un arreglo de destinatarios para enviar el mensaje a varios correos
    ..recipients.addAll(recipients)  // Cambiar al destinatario deseado
    ..subject =  "Nuevo reclamo ingresado : tipo ${nuevoReclamo.tipo} - Cliente: ${nuevoReclamo.nombreCliente} - Embarque: ${nuevoReclamo.embarque}"
    // podrias generar un html para enviarlo como cuerpo del mensaje y darle un formato mas agradable
    ..html = '<h1>Reclamo</h1>\n<p>Cliente: ${nuevoReclamo.nombreCliente}</p>\n<p>Embarque: ${nuevoReclamo.embarque}</p>\n<p>Motivo: ${nuevoReclamo.motivo}</p>\n<p>Producto: ${nuevoReclamo.producto}</p>';
    
  try {
    final sendReport = await send(message, smtpServer);
    debugPrint('Mensaje enviado: ${sendReport.messageSendingEnd}');
  } catch (e) {
    debugPrint('Error al enviar el mensaje: $e');
  }

}