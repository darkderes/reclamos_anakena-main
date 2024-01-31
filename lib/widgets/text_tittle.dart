import '../barrels.dart';

class TextTitle extends StatelessWidget {
  const TextTitle({
    super.key,
    required this.titlle,
    required this.fontSize,
  });
  final String titlle;
  final double fontSize ;

  @override
  Widget build(BuildContext context) {
    return  Text(titlle,
        style: TextStyle(
            fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.brown));
  }
}
