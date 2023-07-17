import 'package:flutter/material.dart';

class TextCheckBox extends StatelessWidget {
  final String label;
  final bool value;
  final void Function(bool?) onChanged;

  const TextCheckBox(
      {super.key,
      required this.label,
      required this.value,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints(maxWidth: 300),
        child: Row(
          children: <Widget>[
            Checkbox(
              value: value,
              onChanged: onChanged,
            ),
            Text(label),
          ],
        ));
  }
}
