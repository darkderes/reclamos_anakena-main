// creame una pantalla de inicio de sesión con un formulario de inicio de sesión con 2 cuadro de texto de mail y password
// y un botón de inicio de sesión
import 'package:reclamos_anakena/barrels.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  bool _isPasswordHidden = true;

  @override
  void initState() {
    super.initState();
    FullScreenWindow.setFullScreen(true);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FullScreenWindow.setFullScreen(true);
    setState(() {});
    // tamaño de la pantalla con mediaquery
    // para centrar el formulario
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio de sesión'),
        actions: <Widget>[
          IconButton(
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
          ),
          // crear para
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            tooltip: 'Cerrar App',
            onPressed: () {
              // salir de app
              if (Platform.isWindows) {
                ExitProcess(0);
              }
              SystemNavigator.pop();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: height * 0.2),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: width * 0.4, vertical: 20),
              child: Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const LogoAnakena(),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _emailController,
                        maxLength: 25,
                        style: const TextStyle(
                          letterSpacing: 2,
                          color: Colors.brown,
                          fontSize: 18,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Correo electrónico',
                        ),
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return 'Por favor ingrese su correo electrónico';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        maxLength: 10,
                        obscureText: _isPasswordHidden,
                        style: const TextStyle(
                            letterSpacing: 2, color: Colors.brown),
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Cambia el ícono dependiendo del estado de _isPasswordHidden
                              _isPasswordHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                // Cambia el estado de visibilidad de la contraseña
                                _isPasswordHidden = !_isPasswordHidden;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor ingrese su contraseña';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final supabase = Supabase.instance.client;

                            try {
                              final AuthResponse res =
                                  await supabase.auth.signInWithPassword(
                                password: _passwordController.text,
                                email: _emailController.text,
                              );

                              final Session? session = res.session;
                              final User? user = res.user;

                              if (session != null && user != null) {
                                debugPrint('User: ${user.email}');
                                debugPrint('Session: ${session.accessToken}');
                                Navigator.pushReplacementNamed(
                                    context, '/home');
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const DialogCustom(
                                      title: 'Error',
                                      resp: 'No se pudo iniciar sesión',
                                    );
                                  },
                                );
                              }
                            } catch (e) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return DialogCustom(
                                    title: 'Error',
                                    resp: e.toString(),
                                  );
                                },
                              );
                            }
                          }
                        },
                        child: const Text('Iniciar sesión'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
