import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:yt_dlp_gui/domain/yt_dlp_config.dart';
import 'package:yt_dlp_gui/domain/yt_dlp_config_enums.dart';
import 'package:yt_dlp_gui/notifiers/yt_dlp_config_notifier.dart';
import 'package:yt_dlp_gui/shell/yt_dlp_command.dart';
import 'package:yt_dlp_gui/ui/widgets/EnumDropDown.dart';
import 'package:yt_dlp_gui/ui/widgets/TextCheckBox.dart';
import 'package:yt_dlp_gui/ui/widgets/TextInputField.dart';

class YtDlpForm extends StatefulWidget {
  const YtDlpForm({super.key});

  @override
  State<YtDlpForm> createState() => _YtDlpFormState();
}

class _YtDlpFormState extends State<YtDlpForm> {
  String _dlPath = "";
  final _ytConfigNotifier =
      YtDlpConfigNotifier(config: YtDlpConfig.defaultConfig());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ValueListenableBuilder(
      valueListenable: _ytConfigNotifier,
      builder: (context, YtDlpConfig config, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextInputField(
              value: config.ytUrl,
              hintText: "Enter YouTube URL",
              onChanged: _ytConfigNotifier.setYtUrl,
            ),
            Container(
              constraints: const BoxConstraints(minWidth: 200, maxWidth: 400),
              child: Row(children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  constraints:
                      const BoxConstraints(minWidth: 250, maxWidth: 350),
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
              value: config.dlVideo,
              onChanged: _ytConfigNotifier.setDlVideo,
            ),
            TextCheckBox(
              label: "Download Audio",
              value: config.dlAudio,
              onChanged: _ytConfigNotifier.setDlAudio,
            ),
            TextCheckBox(
              label: "Download Thumbnail",
              value: config.dlThumbnail,
              onChanged: _ytConfigNotifier.setDlThumbnail,
            ),
            TextCheckBox(
              label: "Download Subtitles",
              value: config.dlSubtitles,
              onChanged: _ytConfigNotifier.setDlSubtitles,
            ),
            Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                children: [
                  Row(
                    children: [
                      EnumDropDown(
                        VideoSize.values,
                        label: "Video Size",
                        onSelected: _ytConfigNotifier.setVideoSize,
                        initialValue: VideoSize.v720p,
                      ),
                      EnumDropDown(
                        VideoFormat.values,
                        label: "Video Format",
                        onSelected: _ytConfigNotifier.setVideoFormat,
                        initialValue: VideoFormat.mp4,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      EnumDropDown(
                        AudioFormat.values,
                        label: "Audio Format",
                        onSelected: _ytConfigNotifier.setAudioFormat,
                        initialValue: AudioFormat.mp3,
                      ),
                      EnumDropDown(
                        AudioBitrate.values,
                        label: "Audio Bitrate",
                        onSelected: _ytConfigNotifier.setAudioBitrate,
                        initialValue: AudioBitrate.a32k,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            FilledButton(
                onPressed: () {
                  var cmd = YtDlpCommand(config, _dlPath);
                  debugPrint(cmd.buildCommand());
                  debugPrint("dlPath $_dlPath");
                  cmd.run();
                },
                child: const Text("Download")),
          ],
        );
      },
    )));
  }
}
