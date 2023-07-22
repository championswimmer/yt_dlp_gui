import 'package:flutter/material.dart';
import 'package:yt_dlp_gui/features/download_form/view/download_form_page.dart';


class DownloadButton extends StatelessWidget {
  const DownloadButton({Key? key, required this.onDownload}) : super(key: key);
  final VoidCallback onDownload;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
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
            onPressed: onDownload,
            child: const Text("Download"),
          );
        });
  }
}
