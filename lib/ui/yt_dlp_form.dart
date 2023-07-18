import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yt_dlp_gui/domain/yt_dlp_config_enums.dart';
import 'package:yt_dlp_gui/notifier/yt_dlp_config_notifier.dart';
import 'package:yt_dlp_gui/shell/yt_dlp_command.dart';
import 'package:yt_dlp_gui/ui/widgets/enum_drop_down.dart';
import 'package:yt_dlp_gui/ui/widgets/text_checkbox.dart';
import 'package:yt_dlp_gui/ui/widgets/text_input_field.dart';
import 'package:yt_dlp_gui/ui/widgets/time_input_field.dart';

ValueNotifier<MaterialStatesController> downloadButtonNotifier =
    ValueNotifier(MaterialStatesController());
ValueNotifier<double> downloadPercentageNotifier = ValueNotifier(0);

class YtDlpForm extends ConsumerStatefulWidget {
  const YtDlpForm({super.key});

  @override
  ConsumerState<YtDlpForm> createState() => _YtDlpFormState();
}

class _YtDlpFormState extends ConsumerState<YtDlpForm> {
  String _dlPath = "";

  @override
  Widget build(BuildContext context) {
    final configApi = ref.watch(ytDlpConfigProvider.notifier);
    final config = ref.watch(ytDlpConfigProvider);
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextInputField(
          value: config.ytUrl,
          hintText: "Enter YouTube URL",
          onChanged: configApi.setYtUrl,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 200),
              child: TimeInputField(
                onChanged: configApi.setStartTime,
              ),
            ),
            Container(
              constraints: const BoxConstraints(maxWidth: 200),
              child: TimeInputField(
                onChanged: configApi.setEndTime,
              ),
            ),
          ],
        ),
        TextCheckBox(
            label: "Download Video",
            value: config.dlVideo,
            onChanged: configApi.setDlVideo),
        TextCheckBox(
            label: "Download Audio",
            value: config.dlAudio,
            onChanged: configApi.setDlAudio),
        TextCheckBox(
            label: "Download Thumbnail",
            value: config.dlThumbnail,
            onChanged: configApi.setDlThumbnail),
        TextCheckBox(
            label: "Download Subtitles",
            value: config.dlSubtitles,
            onChanged: configApi.setDlSubtitles),
        Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            children: [
              Row(
                children: [
                  EnumDropDown(
                    VideoSize.values,
                    label: "Video Size",
                    onSelected: configApi.setVideoSize,
                    initialValue: VideoSize.v720p,
                  ),
                  EnumDropDown(
                    VideoFormat.values,
                    label: "Video Format",
                    onSelected: configApi.setVideoFormat,
                    initialValue: VideoFormat.mp4,
                  ),
                ],
              ),
              Row(
                children: [
                  EnumDropDown(
                    AudioFormat.values,
                    label: "Audio Format",
                    onSelected: configApi.setAudioFormat,
                    initialValue: AudioFormat.mp3,
                  ),
                  EnumDropDown(
                    AudioBitrate.values,
                    label: "Audio Bitrate",
                    onSelected: configApi.setAudioBitrate,
                    initialValue: AudioBitrate.a32k,
                  ),
                ],
              ),
            ],
          ),
        ),
        // TODO: migrate it to use riverpod.
        ValueListenableBuilder(
            valueListenable: downloadButtonNotifier,
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
                  statesController: downloadButtonNotifier.value,
                  onPressed: () {
                    downloadButtonNotifier.value
                        .update(MaterialState.disabled, true);
                    //callig notifyListeners() here cuz dart object equality doesn't recognize changes in the value of the object
                    downloadButtonNotifier.notifyListeners();
                    var cmd = YtDlpCommand(config, _dlPath);
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
