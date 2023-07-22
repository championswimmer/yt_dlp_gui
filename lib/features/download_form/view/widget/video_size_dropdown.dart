import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yt_dlp_gui/domain/yt_dlp_config_enums.dart';
import 'package:yt_dlp_gui/features/download_form/const/download_form_const.dart';

class VideoSizeDropdown extends StatelessWidget {
  const VideoSizeDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown(
      name: DownloadFormConst.videoSize,
      initialValue: VideoSize.values.first,
      decoration: const InputDecoration(
        labelText: 'Video Size',
        hintText: 'Select video size',
      ),
      items: VideoSize.values
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: e.name.text.make(),
            ),
          )
          .toList(),
      validator: FormBuilderValidators.required(),
    ).py8();
  }
}
