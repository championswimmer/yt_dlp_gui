import 'package:flutter/material.dart';
import 'package:yt_dlp_gui/domain/yt_dlp_config.dart';
import 'package:yt_dlp_gui/domain/yt_dlp_config_enums.dart';

class YtDlpConfigNotifier extends ValueNotifier<YtDlpConfig> {
  YtDlpConfigNotifier({
    required YtDlpConfig config,
  }) : super(config);

  void setDlAudio(bool? downloadAudio) {
    value = value.set(dlAudio: downloadAudio);
  }

  void setDlVideo(bool? downloadVideo) {
    value = value.set(dlVideo: downloadVideo);
  }

  void setDlThumbnail(bool? downloadThumbnail) {
    value = value.set(dlThumbnail: downloadThumbnail);
  }

  void setDlSubtitles(bool? downloadSubtitles) {
    value = value.set(dlSubtitles: downloadSubtitles);
  }

  void setYtUrl(String? url) {
    if (url != value.ytUrl) {
      debugPrint("setYtUrl: $value : ${value.ytUrl}");
      value = value.set(ytUrl: url);
    }
  }

  void setVideoSize(VideoSize? videoSize) {
    value = value.set(vSize: videoSize);
  }

  void setAudioBitrate(AudioBitrate? audioBitrate) {
    value = value.set(aBitrate: audioBitrate);
  }

  void setVideoFormat(VideoFormat? videoFormat) {
    value = value.set(vFormat: videoFormat);
  }

  void setAudioFormat(AudioFormat? audioFormat) {
    value = value.set(aFormat: audioFormat);
  }
}
