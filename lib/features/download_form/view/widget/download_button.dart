import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yt_dlp_gui/features/download_form/controller/download_notifier_pod.dart';
import 'package:yt_dlp_gui/features/download_form/state/download_state.dart';

class DownloadButton extends ConsumerWidget {
  const DownloadButton({Key? key, required this.onDownload}) : super(key: key);
  final VoidCallback onDownload;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloadStateAsync = ref.watch(downloadNotifierStatePod);
    return downloadStateAsync.when(
      data: (downloadState) {
        return switch (downloadState) {
          InitialDownloadState() => FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: Vx.red700,
                foregroundColor: Vx.white,
              ),
              icon: const Icon(Icons.download),
              label: 'Download'.text.make(),
              onPressed: onDownload,
            ),
          DownloadingState(:final progress) => progress != 0
              ? CircularProgressIndicator.adaptive(
                  value: progress / 100,
                )
              : [
                  const CircularProgressIndicator.adaptive().p8(),
                  "Starting Download. Please wait".text.make()
                ].vStack(),
          DownloadedState() => FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: Vx.red700,
                foregroundColor: Vx.white,
              ),
              icon: const Icon(Icons.download),
              label: 'Download'.text.make(),
              onPressed: onDownload,
            ),
          DownloadErroState(:final error) => error.text.makeCentered(),
        };
      },
      loading: () => const CircularProgressIndicator.adaptive(),
      error: (error, stackTrace) => FilledButton.icon(
        style: FilledButton.styleFrom(
          backgroundColor: Vx.red700,
          foregroundColor: Vx.white,
        ),
        icon: const Icon(Icons.download),
        label: 'Retry'.text.make(),
        onPressed: onDownload,
      ),
    );
  }
}
