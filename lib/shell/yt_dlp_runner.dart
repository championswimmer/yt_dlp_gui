import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:process_run/shell.dart';

class YtDlpRunner {
  final shell = Shell();
  String appPath = Platform.resolvedExecutable;

  String get appDir =>
      appPath.substring(0, appPath.lastIndexOf(Platform.pathSeparator));

  String get ytDlpWinexe =>
      Directory("$appDir\\data\\flutter_assets\\assets\\executable")
          .listSync()
          .where((element) => element.path.endsWith('yt-dlp.exe'))
          .first
          .path;

  String get ytDlpMacos => Directory(
          "$appDir/../Frameworks/App.Framework/Resources/flutter_assets/assets/executable")
      .listSync()
      .where((element) => element.path.endsWith('yt-dlp_macos'))
      .first
      .path;

  // TODO: fix linux
  String get ytDlpLinux =>
      Directory("$appDir/data/flutter_assets/assets/executable")
          .listSync()
          .first
          .path;

  Future<void> run() async {
    // load yt-dlp from assets
    debugPrint('Loading yt-dlp from assets...');
    debugPrint('App path: $appPath');
    var ytDlpPath = '';
    if (Platform.isLinux) ytDlpPath = ytDlpLinux;
    if (Platform.isMacOS) ytDlpPath = ytDlpMacos;
    if (Platform.isWindows) ytDlpPath = ytDlpWinexe;

    var results = await shell.run(ytDlpPath + " --version");
    for (var element in results) { debugPrint(element.outText); }
  }
}
