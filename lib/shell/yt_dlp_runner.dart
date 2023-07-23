import 'dart:io';
import 'package:flutter/material.dart';
import 'package:process_run/shell.dart';

class YtDlpRunner {
  final String dlPath;
  final String command;

  YtDlpRunner({required this.dlPath, required this.command});

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

  Future<void> run({
    required void Function(double progress) onDownloading,
    required void Function() onComplete,
    required void Function(String error) onError,
    required void Function() onAlreadyDownloaded,
  }) async {
    var controller = ShellLinesController();

    final shell = Shell(
        workingDirectory: dlPath, stdout: controller.sink, verbose: false);
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
            onDownloading(downloadPercentage);
            //     downloadPercentageNotifier.value = downloadPercentage;
          } else if (downloadPercentage == 100) {
            onComplete();
          }
        }
      } else if (event.contains('100%')) {
        onComplete();
      } else if (event.contains('already been downloaded')) {
        onAlreadyDownloaded();
      } else if (event.contains(
          'Please install or provide the path using --ffmpeg-location')) {
        //onError('Please install or provide the path using --ffmpeg-location');
      } else if (event.contains(
          'Requested format is not available. Use --list-formats for a list of available formats')) {
        onError(
            'Requested format is not available. Use --list-formats for a list of available formats');
      }
    });

    // load yt-dlp from assets
    debugPrint('Loading yt-dlp from assets...');
    debugPrint('App path: $appPath');
    var ytDlpPath = '';
    if (Platform.isLinux) ytDlpPath = ytDlpLinux;
    if (Platform.isMacOS) ytDlpPath = ytDlpMacos;
    if (Platform.isWindows) ytDlpPath = ytDlpWinexe;

    try {
      var results = await shell.run("$ytDlpPath $command");
      if (results.outText.contains('downloaded')) {
        onAlreadyDownloaded();
      }
    } on ShellException catch (shellExcetpion) {
      final error = shellExcetpion.result?.stderr.toString();

      if (error.toString().contains('ffmpeg not found.')) {
        onError("Please install FFMPEG. Cannot complete post processing");
        onComplete();
      } else if (error
          .toString()
          .contains('Requested format is not available')) {
        onError(
            "Requested format is not available. Please select available format.");
      } else {
        onError("Failed to download please check selected option");
      }
    }
    shell.kill();
    // downloadButtonNotifier.value.update(MaterialState.disabled, false);
    // //callig notifyListeners() here cuz dart object equality doesn't recognize changes in the value of the object
    // downloadButtonNotifier.notifyListeners();
    // downloadPercentageNotifier.value = 0;
  }
}
