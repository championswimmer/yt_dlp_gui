import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yt_dlp_gui/core/theme/theme.dart';
import 'package:yt_dlp_gui/features/download_form/view/download_form_page.dart';

void main() {
  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'yt-dlp-gui',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const DownloadFormPage(),
    );
  }
}
