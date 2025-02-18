import '../barrels.dart';

class TextObservacion extends StatelessWidget {
  const TextObservacion({
    super.key,
    required this.controller,
    required this.labeltext,
    this.validator
  });

  final TextEditingController controller;
  final String labeltext;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration:  InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labeltext,
      ),
      validator: validator,
      style: const TextStyle(
        //fontSize: 15,
        color: Colors.brown,
      ),
      maxLines: null,
      keyboardType: TextInputType.multiline,
    );
  }
}