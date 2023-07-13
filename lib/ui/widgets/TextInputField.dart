import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final String value;
  final String hintText;

  // String change listener
  final void Function(String? value)? onChanged;

  const TextInputField(
      {super.key,
      required this.hintText,
      required this.value,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController(text: value);
    controller.addListener(() {
      onChanged!(controller.text);
    });
    return Container(
      constraints: const BoxConstraints(minWidth: 200, maxWidth: 400),
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w200), // TODO: can put style elsewhere
        ),
      ),
    );
  }
}
