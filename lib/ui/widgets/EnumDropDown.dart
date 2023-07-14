import 'package:flutter/material.dart';

class EnumDropDown<T extends Enum> extends StatelessWidget {
  final List<T> keys;
  final String label;

  const EnumDropDown(this.keys, {super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuEntry<T>> dropdownMenuEntries = [];
    for (T key in keys) {
      dropdownMenuEntries.add(DropdownMenuEntry<T>(
        label: (key as dynamic).value.toString(),
        value: key,
      ));
    }
    return Container(
      padding: const EdgeInsets.all(10),
      child: DropdownMenu(
        width: 180,
        dropdownMenuEntries: dropdownMenuEntries,
        label: Text(label),
      ),
    );
  }
}
