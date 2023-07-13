import 'package:flutter/material.dart';
import 'package:yt_dlp_gui/domain/yt_dlp_config.dart';
import 'package:yt_dlp_gui/shell/yt_dlp_command.dart';
import 'package:yt_dlp_gui/ui/widgets/TextCheckBox.dart';
import 'package:yt_dlp_gui/ui/widgets/TextInputField.dart';

class YtDlpForm extends StatefulWidget {
  const YtDlpForm({super.key});

  @override
  State<YtDlpForm> createState() => _YtDlpFormState();
}

class _YtDlpFormState extends State<YtDlpForm> {
  YtDlpConfig _config = YtDlpConfig.defaultConfig();

  void setDlAudio(bool? value) {
    setState(() {
      _config = _config.set(dlAudio: value);
    });
  }

  void setDlVideo(bool? value) {
    setState(() {
      _config = _config.set(dlVideo: value);
    });
  }

  void setDlThumbnail(bool? value) {
    setState(() {
      _config = _config.set(dlThumbnail: value);
    });
  }

  void setDlSubtitles(bool? value) {
    setState(() {
      _config = _config.set(dlSubtitles: value);
    });
  }

  void setYtUrl(String? value) {
    if (value != _config.ytUrl) {
      debugPrint(
        "setYtUrl: $value : ${_config.ytUrl}",
      );
      _config = _config.set(ytUrl: value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextInputField(
          value: _config.ytUrl,
          hintText: "Enter YouTube URL",
          onChanged: setYtUrl,
        ),
        TextCheckBox(label: "Download Video", value: _config.dlVideo, onChanged: setDlVideo),
        TextCheckBox(label: "Download Audio", value: _config.dlAudio, onChanged: setDlAudio),
        TextCheckBox(
            label: "Download Thumbnail", value: _config.dlThumbnail, onChanged: setDlThumbnail),
        TextCheckBox(
            label: "Download Subtitles", value: _config.dlSubtitles, onChanged: setDlSubtitles),
        FilledButton(
            onPressed: () => print(YtDlpCommand(_config).buildCommand()),
            child: Text("Download")),
      ],
    )));
  }
}
