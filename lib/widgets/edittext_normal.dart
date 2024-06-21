import '../barrels.dart';

class EditTextNormal extends StatelessWidget {
  const EditTextNormal ({
    super.key,
    required this.controller,
    required this.labeltext,
    required this.hintText,
  });

  final TextEditingController controller;
  final String labeltext;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration:  InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintText,
        labelText: labeltext,
      ),
      style: const TextStyle(
        fontSize: 15,
        color: Colors.brown,
       
      )
    );
  }
}
