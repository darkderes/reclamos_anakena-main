import 'package:reclamos_anakena/barrels.dart';

class IconMinimizar extends StatelessWidget {
  const IconMinimizar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.minimize),
      tooltip: 'Minimizar',
      onPressed: () async {
        // salir de app
        if (Platform.isWindows) {
          final hWnd = GetForegroundWindow();
          ShowWindow(hWnd, SHOW_WINDOW_CMD.SW_MINIMIZE);
        }
        // SystemNavigator.pop();
      },
    );
  }
}