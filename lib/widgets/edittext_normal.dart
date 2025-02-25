import '../barrels.dart';

class EditTextNormal extends StatelessWidget {
  const EditTextNormal ({
    super.key,
    required this.controller,
    required this.labeltext,
    required this.hintText,
    this.validator,
    required this.readOnly,


  });

  final TextEditingController controller;
  final String labeltext;
  final String hintText;
  final String? Function(String?)? validator;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration:  InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintText,
        labelText: labeltext,
        
      ),
      validator: validator,
      style: const TextStyle(
        fontSize: 15,
        color: Colors.brown,
       
      ),
      readOnly: readOnly,
    );
  }
}
