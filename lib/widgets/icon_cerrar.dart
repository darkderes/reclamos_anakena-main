import 'package:reclamos_anakena/barrels.dart';

class IconCerrar extends StatelessWidget {
  const IconCerrar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.exit_to_app),
      tooltip: 'Cerrar App',
      onPressed: () {
        // salir de app
        if (Platform.isWindows) {
          ExitProcess(0);
        }
        SystemNavigator.pop();
      },
    );
  }
}
