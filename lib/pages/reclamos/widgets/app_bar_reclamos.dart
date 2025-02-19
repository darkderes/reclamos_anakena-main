import 'package:reclamos_anakena/barrels.dart';

class AppBarAdd extends StatelessWidget implements PreferredSizeWidget  {
  const AppBarAdd({
    super.key,
    required this.widget,
    required int currentStep,
    required this.myProvider,
  }) : _currentStep = currentStep;

  final AddReclamosPage widget;
  final int _currentStep;
  final Myprovider myProvider;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      actions: [
        const UserData(),
        Visibility(
          visible: _currentStep == 2 ? true : false,
          child: IconButton(
            icon: const Icon(Icons.all_inbox_rounded, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, "/galery_files",
                  arguments: myProvider.reclamoId);
            },
          ),
        ),
        Visibility(
          visible: _currentStep == 2 ? true : false,
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
                      child: LoadFiles(id: myProvider.reclamoId),
                    ),
                  );
                },
              );
            },
          ),
        ),
        Visibility(
          visible: _currentStep == 2 ? true : false,
          child: IconButton(
            icon: const Icon(Icons.collections, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, "/galery_screen",
                  arguments: myProvider.reclamoId);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Visibility(
            visible: _currentStep == 2 ? true : false,
            child: IconButton(
                onPressed: () async {
                  cargarYGuardarImagenes(context, "Comercial", myProvider.reclamoId);
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
