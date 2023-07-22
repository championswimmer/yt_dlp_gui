import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yt_dlp_gui/features/download_form/const/download_form_const.dart';

class DownloadCheckboxes extends StatelessWidget {
  const DownloadCheckboxes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderCheckboxGroup<String>(
      name: DownloadFormConst.downloadVideoOption,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: const InputDecoration(
        labelText: 'Select download options',
      ),
      initialValue: const ['video'],
      options: [
        FormBuilderFieldOption(
          value: 'video',
          child: "Download Video".text.make(),
        ),
        FormBuilderFieldOption(
          value: 'audio',
          child: "Download Audio".text.make(),
        ),
        FormBuilderFieldOption(
          value: 'thumbnail',
          child: "Download Thumbnail".text.make(),
        ),
        FormBuilderFieldOption(
          value: 'subtitle',
          child: "Download Subtitle".text.make(),
        ),
      ],
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.required(
            errorText: 'Please select atleast one download option',
          ),
        ],
      ),
    ).py8();
  }
}
