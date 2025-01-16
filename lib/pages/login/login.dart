import 'package:reclamos_anakena/barrels.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}
class _LoginState extends State<Login> {

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();


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

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio de sesión'),
        actions: const <Widget>[
          IconMinimizar(),
          IconCerrar(),
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
                    spacing: 20,
                    children: [
                      const LogoAnakena(),
                      TxtCorreo(emailController: _emailController),
                      TxtPassword(controller: _passwordController),
                      ButtonLogin(formKey: _formKey, emailController: _emailController, passwordController: _passwordController),
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