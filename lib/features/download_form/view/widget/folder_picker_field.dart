import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:io' as io;
import 'package:yt_dlp_gui/features/download_form/const/download_form_const.dart';

class FolderPickerField extends StatelessWidget {
  const FolderPickerField({Key? key, required this.onFolderClicked})
      : super(key: key);
  final VoidCallback onFolderClicked;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: DownloadFormConst.folderpath,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        (value) {
          final isValidpath = io.Directory(value ?? "").existsSync();
          if (!isValidpath) {
            return "Please select a valid path";
          } else {
            return null;
          }
        },
      ]),
      decoration: InputDecoration(
        hintText: "Download Path",
        labelText: "Select folder",
        alignLabelWithHint: true,
        suffixIcon: IconButton(
          icon: const Icon(Icons.folder_open),
          onPressed: onFolderClicked,
        ),
      ),
    ).py8();
  }
}
