import '../barrels.dart';

class TextObservacion extends StatelessWidget {
  const TextObservacion({
    super.key,
    required this.controller,
    required this.labeltext,
  });

  final TextEditingController controller;
  final String labeltext;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration:  InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labeltext,
      ),
      style: const TextStyle(
        //fontSize: 15,
        color: Colors.brown,
      ),
      maxLines: null,
      keyboardType: TextInputType.multiline,
    );
  }
}