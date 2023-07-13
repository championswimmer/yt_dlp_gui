import 'package:flutter/material.dart';
import 'package:yt_dlp_gui/domain/yt_dlp_config_enums.dart';

class IntEnumDropDown<T extends IntEnum> extends StatelessWidget {
  final List<T> keys;
  final String label;

  const IntEnumDropDown(this.keys, {super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuEntry<T>> dropdownMenuEntries = [];
    for (T key in keys) {
      dropdownMenuEntries.add(DropdownMenuEntry<T>(
        label: key.value.toString(),
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
