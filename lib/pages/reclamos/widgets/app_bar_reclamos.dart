import 'package:reclamos_anakena/barrels.dart';

class AppBarAdd extends StatelessWidget implements PreferredSizeWidget {
  const AppBarAdd({
    super.key,
    required this.title,
    required this.reclamo,
    required this.perfil,
  });

  final String title;
  final Reclamo reclamo;
  final String perfil;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        Visibility(
          visible: reclamo.objectId != null ? true : false,
          child: Badge.count(
            count: reclamo.archivos.length,
            child: IconButton(
              icon: const Icon(Icons.all_inbox_rounded, color: Colors.white),
              onPressed: () {
                Navigator.pushNamed(context, "/galery_files",
                   arguments: {
                      'reclamo': reclamo,
                      'perfil': perfil,
                    },);
              },
            ),
          ),
        ),
   
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Visibility(
            visible: reclamo.objectId != null ? true : false,
            child: Badge.count(
              count: reclamo.imagenes.length,
              child: IconButton(
                icon: const Icon(Icons.collections, color: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    "/galery_screen",
                    arguments: {
                      'reclamo': reclamo,
                      'perfil': perfil,
                    },
                  );
                },
              ),
            ),
          ),
        ),
        const UserData(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
