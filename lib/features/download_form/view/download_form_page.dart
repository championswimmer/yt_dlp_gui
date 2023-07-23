import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:yt_dlp_gui/domain/yt_dlp_config.dart';
import 'package:yt_dlp_gui/domain/yt_dlp_config_enums.dart';
import 'package:yt_dlp_gui/features/download_form/const/download_form_const.dart';
import 'package:yt_dlp_gui/features/download_form/view/widget/audio_bitrate_dropdown.dart';
import 'package:yt_dlp_gui/features/download_form/view/widget/audio_format_dropdown.dart';
import 'package:yt_dlp_gui/features/download_form/view/widget/download_button.dart';
import 'package:yt_dlp_gui/features/download_form/view/widget/download_option_checkbox.dart';
import 'package:yt_dlp_gui/features/download_form/view/widget/end_duration_field.dart';
import 'package:yt_dlp_gui/features/download_form/view/widget/folder_picker_field.dart';
import 'package:yt_dlp_gui/features/download_form/view/widget/sponsor_checkbox.dart';
import 'package:yt_dlp_gui/features/download_form/view/widget/start_duration_field.dart';
import 'package:yt_dlp_gui/features/download_form/view/widget/video_format_dropdown.dart';
import 'package:yt_dlp_gui/features/download_form/view/widget/video_size_dropdown.dart';
import 'package:yt_dlp_gui/features/download_form/view/widget/yt_url_field.dart';
import 'package:yt_dlp_gui/shell/yt_dlp_command.dart';

final ValueNotifier<MaterialStatesController> downloadButtonNotifier =
    ValueNotifier(MaterialStatesController());
final ValueNotifier<double> downloadPercentageNotifier = ValueNotifier(0);

class DownloadFormPage extends StatelessWidget {
  const DownloadFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DownloadFormView();
  }
}

class DownloadFormView extends StatefulWidget {
  const DownloadFormView({super.key});

  @override
  State<DownloadFormView> createState() => _DownloadFormViewState();
}

class _DownloadFormViewState extends State<DownloadFormView> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  void selectFolder() async {
    final path = await FilePicker.platform.getDirectoryPath();
    if (path != null) {
      _formKey.currentState?.fields[DownloadFormConst.folderpath]
          ?.didChange(path);
    }
  }

  void downloadClicked() async {
    if (_formKey.currentState?.validate() ?? false) {
      final fields = _formKey.currentState?.fields;
      final ytUrl = fields?[DownloadFormConst.ytUrl]?.value as String;
      final path = fields?[DownloadFormConst.folderpath]?.value as String;
      final startTime =
          fields?[DownloadFormConst.startDuration]?.value as String?;
      final endTime = fields?[DownloadFormConst.endDuration]?.value as String?;
      final downloadoptionrecord =
          fields?[DownloadFormConst.downloadVideoOption]?.value as List<String>;
      final videosize =
          fields?[DownloadFormConst.videoSize]?.value as VideoSize;
      final videoformat =
          fields?[DownloadFormConst.videoFormat]?.value as VideoFormat;
      final audiobitrate =
          fields?[DownloadFormConst.audioBitRate]?.value as AudioBitrate;
      final audioformat =
          fields?[DownloadFormConst.audioFormat]?.value as AudioFormat;

      final sponsorblock =
          fields?[DownloadFormConst.sponsorBlock]?.value as bool?;

      downloadButtonNotifier.value.update(MaterialState.disabled, true);
      //callig notifyListeners() here cuz dart object equality doesn't recognize changes in the value of the object
      downloadButtonNotifier.notifyListeners();
      final config = YtDlpConfig(
        ytUrl: ytUrl,
        startTime: startTime,
        endTime: endTime,
        dlVideo: downloadoptionrecord.contains('video'),
        dlAudio: downloadoptionrecord.contains('audio'),
        dlThumbnail: downloadoptionrecord.contains('thumbnail'),
        dlSubtitles: downloadoptionrecord.contains('subtitle'),
        vSize: videosize,
        aBitrate: audiobitrate,
        vFormat: videoformat,
        aFormat: audioformat,
        sponsorBlock: sponsorblock ?? false,
      );
      var cmd = YtDlpCommand(config, path);
      debugPrint(cmd.buildCommand());
      debugPrint("dlPath $path");
      cmd.run();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Yt downloader'.text.make(),
        automaticallyImplyLeading: false,
      ),
      body: FormBuilder(
        key: _formKey,
        child: <Widget>[
          YtUrlField(),
          FolderPickerField(onFolderClicked: selectFolder),
          <Widget>[
            const StartDurationField().flexible(),
            12.widthBox,
            const EndDurationField().flexible(),
          ]
              .hStack(
                alignment: MainAxisAlignment.spaceAround,
              )
              .py8(),
          const DownloadCheckboxes(),
          const SponsorCheckbox(),
          const VideoSizeDropdown(),
          const VideoFormatDropdown(),
          const AudioFormatDropdown(),
          const AudioBitrateDropdown(),
          DownloadButton(onDownload: downloadClicked),
        ].vStack().p16().scrollVertical().safeArea(),
      ),
    );
  }
}
