// import 'package:reclamos_anakena/barrels.dart';

// void sendEmail(Reclamo nuevoReclamo) async {
//   String username = 'alerta@anakena.cl';
//   String password = 'Paine164';

//   // Crear el servidor de correo electrónico para office365
//     final smtpServer = SmtpServer(
//     'smtp.office365.com',
//     port: 587,
//     ssl: false,
//     ignoreBadCertificate: true,
//     allowInsecure: true,
//     username: username,
//     password: password,
//   );

//   // Crear el mensaje de correo electrónico
//   final message = Message()
//     ..from = Address(username, 'Anakena Alerta')
//     // tengo un arreglo de destinatarios para enviar el mensaje a varios correos
//     ..recipients.addAll(recipients)  // Cambiar al destinatario deseado
//     ..subject =  "Nuevo reclamo ingresado : tipo ${nuevoReclamo.tipo} - Cliente: ${nuevoReclamo.nombreCliente} - Embarque: ${nuevoReclamo.embarque}"
//     // podrias generar un html para enviarlo como cuerpo del mensaje y darle un formato mas agradable
//     ..html = '<h1>Reclamo</h1>\n<p>Cliente: ${nuevoReclamo.nombreCliente}</p>\n<p>Embarque: ${nuevoReclamo.embarque}</p>\n<p>Motivo: ${nuevoReclamo.motivo}</p>\n<p>Producto: ${nuevoReclamo.producto}</p>';
    
//   try {
//     final sendReport = await send(message, smtpServer);
//     debugPrint('Mensaje enviado: ${sendReport.messageSendingEnd}');
//   } catch (e) {
//     debugPrint('Error al enviar el mensaje: $e');
//   }

// }

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
    ..recipients.addAll(recipients)  // Lista de destinatarios
    ..subject = "Nuevo reclamo ingresado : tipo ${nuevoReclamo.tipo} - Cliente: ${nuevoReclamo.nombreCliente} - Embarque: ${nuevoReclamo.embarque}"
    ..html = """
      <!DOCTYPE html>
      <html>
      <head>
          <meta charset='UTF-8'>
          <meta name='viewport' content='width=device-width, initial-scale=1.0'>
          <title>Nuevo Reclamo</title>
          <style>
              body {
                  font-family: Arial, sans-serif;
                  background-color: #f4f4f4;
                  margin: 0;
                  padding: 20px;
              }
              .container {
                  max-width: 600px;
                  background: #ffffff;
                  padding: 20px;
                  border-radius: 8px;
                  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
              }
              h1 {
                  color: #d9534f;
                  text-align: center;
              }
              p {
                  font-size: 16px;
                  color: #333;
              }
              .footer {
                  text-align: center;
                  font-size: 12px;
                  color: #777;
                  margin-top: 20px;
              }
          </style>
      </head>
      <body>
          <div class='container'>
              <h1>Reclamo Ingresado</h1>
              <p><strong>Cliente:</strong> ${nuevoReclamo.nombreCliente}</p>
              <p><strong>Embarque:</strong> ${nuevoReclamo.embarque}</p>
              <p><strong>Motivo:</strong> ${nuevoReclamo.motivo}</p>
              <p><strong>Producto:</strong> ${nuevoReclamo.producto}</p>
          </div>
          <div class='footer'>
              <p>Este es un mensaje automático, por favor no responda.</p>
          </div>
      </body>
      </html>
    """;

  try {
    final sendReport = await send(message, smtpServer);
    debugPrint('Mensaje enviado: ${sendReport.messageSendingEnd}');
  } catch (e) {
    debugPrint('Error al enviar el mensaje: \$e');
  }
}
