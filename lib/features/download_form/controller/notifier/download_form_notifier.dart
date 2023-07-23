import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yt_dlp_gui/domain/yt_dlp_config.dart';
import 'package:yt_dlp_gui/features/download_form/state/download_state.dart';
import 'package:yt_dlp_gui/shell/yt_dlp_command.dart';

class DownloadFormNotifier extends AutoDisposeAsyncNotifier<DownloadState> {
  @override
  FutureOr<DownloadState> build() {
    return InitialDownloadState();
  }

  Future<void> startDownload({
    required YtDlpConfig config,
    required String dlPath,
    required void Function() onCompleted,
    required void Function(String error) onError,
    required void Function() onAlreadyDownloaded,
  }) async {
    state = AsyncData(DownloadingState(progress: 0));
    await AsyncValue.guard(() async {
      YtDlpCommand(config, dlPath).run(
        onDownloading: (progress) {
          state = AsyncData(DownloadingState(progress: progress));
        },
        onComplete: () {
          onCompleted();
          state = AsyncData(DownloadedState());
        },
        onError: (error) {
          if (state.value != DownloadedState()) {
            onError(error);
            state = AsyncError(error, StackTrace.current);
          }
        },
        onAlreadyDownloaded: () {
          onAlreadyDownloaded();
          state = AsyncData(InitialDownloadState());
        },
      );
    });
  }
}
