import 'package:flutter/material.dart';

class TextInputField extends StatefulWidget {
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
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  late TextEditingController controller =
      TextEditingController(text: widget.value);
  @override
  void initState() {
    controller.addListener(() {
      widget.onChanged!(controller.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      constraints: const BoxConstraints(minWidth: 200, maxWidth: 400),
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: theme.textTheme.titleSmall?.copyWith(color: Colors.grey),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
