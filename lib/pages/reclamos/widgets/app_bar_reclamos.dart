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
        const UserData(),
        Visibility(
          visible: reclamo.objectId != null ? true : false,
          child: IconButton(
            icon: const Icon(Icons.all_inbox_rounded, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, "/galery_files", arguments: reclamo);
            },
          ),
        ),
        Visibility(
          visible: reclamo.objectId != null ? true : false,
          child: IconButton(
            icon: const Icon(Icons.cloud_download_sharp, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    child: SizedBox(
                      // Puedes ajustar el tamaño del contenedor según tus necesidades
                      width: 500,
                      height: 300,
                      child: LoadFiles(
                        seccion: perfil,
                        reclamo: reclamo,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        Visibility(
          visible: reclamo.objectId != null ? true : false,
          child: IconButton(
            icon: const Icon(Icons.collections, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, "/galery_screen",
                  arguments: reclamo);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Visibility(
            visible: reclamo.objectId != null ? true : false,
            child: IconButton(
                onPressed: () async {
                  cargarYGuardarImagenes(context,perfil, reclamo);
                },
                icon: const Icon(Icons.add_a_photo_sharp)),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
