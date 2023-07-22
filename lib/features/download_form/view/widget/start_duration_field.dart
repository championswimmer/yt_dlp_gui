import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:yt_dlp_gui/features/download_form/const/download_form_const.dart';
import 'package:yt_dlp_gui/shared/duration_formatter.dart';



class StartDurationField extends StatelessWidget {
  const StartDurationField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: DownloadFormConst.startDuration,
      keyboardType: const TextInputType.numberWithOptions(decimal: false),
      decoration: const InputDecoration(
        hintText: '00:00:00',
        labelText: "Start Duration",
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: <TextInputFormatter>[
        TimeTextInputFormatter() // This input formatter will do the job
      ],
    );
  }
}
