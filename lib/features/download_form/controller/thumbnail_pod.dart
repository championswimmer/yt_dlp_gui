import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yt_dlp_gui/features/download_form/controller/url_pod.dart';


final thumbanailUrlPod = StateProvider.autoDispose<String?>((ref) {
  final url = ref.watch(urlPod);
  if (url != null && url.contains('v=')) {
    final idindex = url.lastIndexOf('v=') + 2;
    final thumburl =
        'https://i1.ytimg.com/vi/${url.substring(idindex)}/sddefault.jpg';
    return thumburl;
  }
  return null;
});
