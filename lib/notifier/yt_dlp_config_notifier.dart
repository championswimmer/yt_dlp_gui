import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yt_dlp_gui/domain/yt_dlp_config.dart';
import 'package:yt_dlp_gui/domain/yt_dlp_config_enums.dart';

class YtDlpConfigNotifier extends Notifier<YtDlpConfig> {
  final YtDlpConfig _config;

  YtDlpConfigNotifier(this._config);

  @override
  build() => _config;

  void setDlAudio(bool? downloadAudio) {
    state = state.set(dlAudio: downloadAudio);
  }

  void setDlVideo(bool? downloadVideo) {
    state = state.set(dlVideo: downloadVideo);
  }

  void setDlThumbnail(bool? downloadThumbnail) {
    state = state.set(dlThumbnail: downloadThumbnail);
  }

  void setDlSubtitles(bool? downloadSubtitles) {
    state = state.set(dlSubtitles: downloadSubtitles);
  }

  void setYtUrl(String? url) {
    if (url != state.ytUrl) {
      debugPrint("setYtUrl: $state : ${state.ytUrl}");
      state = state.set(ytUrl: url);
    }
  }

  void setVideoSize(VideoSize? videoSize) {
    state = state.set(vSize: videoSize);
  }

  void setAudioBitrate(AudioBitrate? audioBitrate) {
    state = state.set(aBitrate: audioBitrate);
  }

  void setVideoFormat(VideoFormat? videoFormat) {
    state = state.set(vFormat: videoFormat);
  }

  void setAudioFormat(AudioFormat? audioFormat) {
    state = state.set(aFormat: audioFormat);
  }

  void setStartTime(String? value) {
    state = state.set(startTime: value);
  }

  void setEndTime(String? value) {
    state = state.set(endTime: value);
  }
}

final ytDlpConfigProvider = NotifierProvider<YtDlpConfigNotifier, YtDlpConfig>(
  () => YtDlpConfigNotifier(YtDlpConfig.defaultConfig()),
);
