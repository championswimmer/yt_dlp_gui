import 'package:flutter/material.dart';
import 'package:yt_dlp_gui/domain/yt_dlp_config.dart';

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

  @override
  Widget build(BuildContext context) {
    Widget buildCheckBoxRow(
        String label, bool value, void Function(bool?) onChanged) {
      return Container(
          constraints: const BoxConstraints(maxWidth: 300),
          child: Row(
            children: <Widget>[
              Checkbox(
                value: value,
                onChanged: onChanged,
              ),
              Text(label),
            ],
          ));
    }

    return Scaffold(
        body: Center(
            heightFactor: double.infinity,
            widthFactor: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildCheckBoxRow("Download Video", _config.dlVideo, setDlVideo),
                buildCheckBoxRow("Download Audio", _config.dlAudio, setDlAudio),
                buildCheckBoxRow(
                    "Download Thumbnail", _config.dlThumbnail, setDlThumbnail),
                buildCheckBoxRow(
                    "Download Subtitles", _config.dlSubtitles, setDlSubtitles),
              ],
            )));
  }
}
