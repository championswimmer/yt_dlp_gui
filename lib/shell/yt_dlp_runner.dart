import 'dart:io';

import 'package:flutter/material.dart';
import 'package:process_run/shell.dart';
import 'package:yt_dlp_gui/ui/yt_dlp_form.dart';

class YtDlpRunner {
  final String dlPath;
  final String command;

  YtDlpRunner({required this.dlPath, required this.command});

  String appPath = Platform.resolvedExecutable;

  String get appDir => appPath.substring(0, appPath.lastIndexOf(Platform.pathSeparator));

  String get ytDlpWinexe => Directory("$appDir\\data\\flutter_assets\\assets\\executable")
      .listSync()
      .where((element) => element.path.endsWith('yt-dlp.exe'))
      .first
      .path;

  String get ytDlpMacos => Directory("$appDir/../Frameworks/App.Framework/Resources/flutter_assets/assets/executable")
      .listSync()
      .where((element) => element.path.endsWith('yt-dlp_macos'))
      .first
      .path;

  // TODO: fix linux
  String get ytDlpLinux => Directory("$appDir/data/flutter_assets/assets/executable").listSync().first.path;

  Future<void> run() async {
    var controller = ShellLinesController();

    final shell = Shell(workingDirectory: dlPath, stdout: controller.sink, verbose: false);
    //regex to extract download progress
    final RegExp downloadProgressRegExp = RegExp(r'\[download\]\s+(\d+\.\d+)%');
    // listen to stdout
    controller.stream.listen((event) {
      if (event.startsWith('[download]')) {
        debugPrint(event);
        var match = downloadProgressRegExp.firstMatch(event);
        if (match != null && match.group(1) != null) {
          var downloadPercentage = double.parse(match.group(1)!);
          if (downloadPercentage < 100) {
            downloadPercentageNotifier.value = downloadPercentage;
          }
        }
      }
    });

    // load yt-dlp from assets
    debugPrint('Loading yt-dlp from assets...');
    debugPrint('App path: $appPath');
    var ytDlpPath = '';
    if (Platform.isLinux) ytDlpPath = ytDlpLinux;
    if (Platform.isMacOS) ytDlpPath = ytDlpMacos;
    if (Platform.isWindows) ytDlpPath = ytDlpWinexe;

    var results = await shell.run("$ytDlpPath $command");
    downloadButtonNotifier.value.update(MaterialState.disabled, false);
    //callig notifyListeners() here cuz dart object equality doesn't recognize changes in the value of the object
    downloadButtonNotifier.notifyListeners();
    downloadPercentageNotifier.value = 0;
  }
}
