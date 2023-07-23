import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yt_dlp_gui/features/download_form/controller/notifier/download_form_notifier.dart';
import 'package:yt_dlp_gui/features/download_form/state/download_state.dart';

final downloadNotifierStatePod =
    AsyncNotifierProvider.autoDispose<DownloadFormNotifier, DownloadState>(
        DownloadFormNotifier.new);
