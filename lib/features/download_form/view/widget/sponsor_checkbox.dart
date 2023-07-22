import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yt_dlp_gui/features/download_form/const/download_form_const.dart';

class SponsorCheckbox extends StatelessWidget {
  const SponsorCheckbox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderCheckbox(
      name: DownloadFormConst.sponsorBlock,
      title: "Sponsor Block".text.make(),
    ).py8();
  }
}
