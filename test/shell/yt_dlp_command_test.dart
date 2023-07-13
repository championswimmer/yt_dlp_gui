import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yt_dlp_gui/domain/yt_dlp_config.dart';

import 'package:yt_dlp_gui/shell/yt_dlp_command.dart';

void main () {
  group('YtDlpCommand', () {
    test('download video only', () {
      var ytDlpCommand = YtDlpCommand(YtDlpConfig.defaultConfig());
      expect(ytDlpCommand.buildCommand(), ' -k');
    });
  });
}
