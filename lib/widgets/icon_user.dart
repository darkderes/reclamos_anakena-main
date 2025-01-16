import 'package:reclamos_anakena/barrels.dart';

class UserData extends StatefulWidget {
   const UserData({
    super.key,
  });

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
   String nombre = '';
   String rol = '';
   String img = '';

  @override
  void initState() {
    super.initState();

    _loadUserData();
    
  }
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nombre = prefs.getString('nombre') ?? 'Usuario';
      rol = prefs.getString('rol') ?? 'Rol';
      img = prefs.getString('img') ?? '';
    });
  }

  String _getInitials(String name) {
    if (name.trim().isEmpty) {
      return ''; // Retorna una cadena vacía si el nombre está vacío o contiene solo espacios
    }

    List<String> nameParts = name.split(' ');
    if (nameParts.length >= 2) {
      return nameParts[0][0] + nameParts[1][0];
    } else if (nameParts.length == 1) {
      return nameParts[0][0];
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
     
    return PopupMenuButton<String>(
      onSelected: (String result) {
        switch (result) {
          case 'signout':
              signOut(context);
            break;
          case 'changeData':
            // _changeUserData();
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'changeData',
          child: Row(
            children: [
              const Icon(Icons.person, color: Color.fromARGB(255, 107, 93, 16)),
              Text(nombre),
            ],
          ),
        ),
        const PopupMenuItem<String>(
          value: 'signout',
          child: Row(
            children: [
              Icon(Icons.exit_to_app, color: Colors.red),
              SizedBox(width: 8),
              Text('Cerrar sesión'),
            ],
          ),
        ),
      ],
      child: CircleAvatar(
        backgroundColor: const Color.fromARGB(255, 122, 93, 49),
        child: Text(
         _getInitials(nombre),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
