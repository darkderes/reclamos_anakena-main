
import '../barrels.dart';
class LogoAnakena extends StatelessWidget {
  const LogoAnakena({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
        'assets/images/ANAKENA.png',width: 200,height: 50,fit: BoxFit.fill);
  }
}
