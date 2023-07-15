import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:yt_dlp_gui/domain/yt_dlp_config.dart';
import 'package:yt_dlp_gui/domain/yt_dlp_config_enums.dart';
import 'package:yt_dlp_gui/shell/yt_dlp_command.dart';
import 'package:yt_dlp_gui/ui/widgets/EnumDropDown.dart';
import 'package:yt_dlp_gui/ui/widgets/TextCheckBox.dart';
import 'package:yt_dlp_gui/ui/widgets/TextInputField.dart';

ValueNotifier<MaterialStatesController> downloadButtonNotifer =
    ValueNotifier(MaterialStatesController());
ValueNotifier<double> downloadPercentageNotifier = ValueNotifier(0);

class YtDlpForm extends StatefulWidget {
  const YtDlpForm({super.key});

  @override
  State<YtDlpForm> createState() => _YtDlpFormState();
}

class _YtDlpFormState extends State<YtDlpForm> {
  YtDlpConfig _config = YtDlpConfig.defaultConfig();

  String _dlPath = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
    _config = _config.set(dlThumbnail: value);
    setState(() {});
  }

  void setDlSubtitles(bool? value) {
    setState(() {
      _config = _config.set(dlSubtitles: value);
    });
  }

  void setYtUrl(String? value) {
    if (value != _config.ytUrl) {
      debugPrint("setYtUrl: $value : ${_config.ytUrl}");
      _config = _config.set(ytUrl: value);
    }
  }

  void setVideoSize(VideoSize? value) {
    setState(() {
      _config = _config.set(vSize: value);
    });
  }

  void setAudioBitrate(AudioBitrate? value) {
    setState(() {
      _config = _config.set(aBitrate: value);
    });
  }

  void setVideoFormat(VideoFormat? value) {
    setState(() {
      _config = _config.set(vFormat: value);
    });
  }

  void setAudioFormat(AudioFormat? value) {
    setState(() {
      _config = _config.set(aFormat: value);
    });
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
        Container(
          constraints: const BoxConstraints(minWidth: 200, maxWidth: 400),
          child: Row(children: [
            Container(
              padding: const EdgeInsets.all(10),
              constraints: const BoxConstraints(minWidth: 250, maxWidth: 350),
              child: TextField(
                controller: TextEditingController(text: _dlPath),
                decoration: const InputDecoration(
                  hintText: "Download Path",
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight:
                          FontWeight.w200), // TODO: can put style elsewhere
                ),
                onChanged: (value) {},
              ),
            ),
            IconButton(
              icon: const Icon(Icons.folder_open),
              onPressed: () {
                FilePicker.platform.getDirectoryPath().then((value) {
                  if (value != null) {
                    setState(() {
                      _dlPath = value;
                    });
                  }
                });
              },
            )
          ]),
        ),
        TextCheckBox(
            label: "Download Video",
            value: _config.dlVideo,
            onChanged: setDlVideo),
        TextCheckBox(
            label: "Download Audio",
            value: _config.dlAudio,
            onChanged: setDlAudio),
        TextCheckBox(
            label: "Download Thumbnail",
            value: _config.dlThumbnail,
            onChanged: setDlThumbnail),
        TextCheckBox(
            label: "Download Subtitles",
            value: _config.dlSubtitles,
            onChanged: setDlSubtitles),
        Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            children: [
              Row(
                children: [
                  EnumDropDown(
                    VideoSize.values,
                    label: "Video Size",
                    onSelected: setVideoSize,
                    initialValue: VideoSize.v720p,
                  ),
                  EnumDropDown(
                    VideoFormat.values,
                    label: "Video Format",
                    onSelected: setVideoFormat,
                    initialValue: VideoFormat.mp4,
                  ),
                ],
              ),
              Row(
                children: [
                  EnumDropDown(
                    AudioFormat.values,
                    label: "Audio Format",
                    onSelected: setAudioFormat,
                    initialValue: AudioFormat.mp3,
                  ),
                  EnumDropDown(
                    AudioBitrate.values,
                    label: "Audio Bitrate",
                    onSelected: setAudioBitrate,
                    initialValue: AudioBitrate.a32k,
                  ),
                ],
              ),
            ],
          ),
        ),
        ValueListenableBuilder(
            valueListenable: downloadButtonNotifer,
            builder: (context, value, child) {
              if (value.value.contains(MaterialState.disabled)) {
                return ValueListenableBuilder(
                    valueListenable: downloadPercentageNotifier,
                    builder: (context, percentage, child) {
                      if (percentage == 0) {
                        return const Text("Loading yt-dlp...");
                      }
                      return CircularProgressIndicator(
                        value: percentage / 100,
                      );
                    });
              }
              return FilledButton(
                  statesController: downloadButtonNotifer.value,
                  onPressed: () {
                    downloadButtonNotifer.value
                        .update(MaterialState.disabled, true);
                    //callig notifyListeners() here cuz dart object equality doesn't recognize changes in the value of the object
                    downloadButtonNotifer.notifyListeners();
                    var cmd = YtDlpCommand(_config, _dlPath);
                    debugPrint(cmd.buildCommand());
                    debugPrint("dlPath $_dlPath");
                    cmd.run();
                  },
                  child: const Text("Download"));
            }),
      ],
    )));
  }
}
