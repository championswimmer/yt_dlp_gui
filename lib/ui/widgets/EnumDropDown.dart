import 'package:flutter/material.dart';
import 'package:yt_dlp_gui/domain/yt_dlp_config_enums.dart';

class EnumDropDown<T extends StringEnum> extends StatelessWidget {
  final List<T> keys;
  final String label;
  final ValueChanged<T?>? onSelected;

  const EnumDropDown(this.keys,
      {super.key, required this.label, this.onSelected});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<DropdownMenuEntry<T>> dropdownMenuEntries = [];
    for (T key in keys) {
      dropdownMenuEntries.add(DropdownMenuEntry<T>(
          label: key.value.toString(),
          value: key,
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all(
              theme.textTheme.titleSmall,
            ),
          )));
    }
    return Container(
      padding: const EdgeInsets.all(10),
      child: DropdownMenu(
        width: 180,
        onSelected: onSelected,
        dropdownMenuEntries: dropdownMenuEntries,
        label: Text(
          label,
          style: theme.textTheme.titleSmall,
        ),
      ),
    );
  }
}
