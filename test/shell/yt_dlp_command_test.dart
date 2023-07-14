import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yt_dlp_gui/domain/yt_dlp_config.dart';

import 'package:yt_dlp_gui/shell/yt_dlp_command.dart';

void main () {
  group('YtDlpCommand', () {
    test('download video only', () {
      var ytDlpCommand = YtDlpCommand(YtDlpConfig.defaultConfig(), "~/Downloads");
      expect(ytDlpCommand.buildCommand(), ' -k -S "res:720,ext:mp4" --audio-quality 44k --audio-format mp3 ');
    });
  });
}
