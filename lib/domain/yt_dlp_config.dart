import 'package:yt_dlp_gui/domain/yt_dlp_config_enums.dart';

/// YtDlpConfig
/// [ytUrl] - YouTube URL
/// [dlVideo] - Download video flag
/// [dlAudio] - Download audio flag
/// [dlThumbnail] - Download thumbnail flag
/// [dlSubtitles] - Download subtitles flag
class YtDlpConfig {
  final String ytUrl;

  final bool dlVideo;
  final bool dlAudio;
  final bool dlThumbnail;
  final bool dlSubtitles;

  final VideoSize vSize;
  final AudioBitrate aBitrate;

  final VideoFormat vFormat;
  final AudioFormat aFormat;

  /// Constructor
  const YtDlpConfig({
    required this.ytUrl,
    required this.dlVideo,
    required this.dlAudio,
    required this.dlThumbnail,
    required this.dlSubtitles,
    required this.vSize,
    required this.aBitrate,
    required this.vFormat,
    required this.aFormat,
  });

  @override
  String toString() {
    return 'YtDlpConfig{ytUrl: $ytUrl, dlVideo: $dlVideo, dlAudio: $dlAudio, dlThumbnail: $dlThumbnail, dlSubtitles: $dlSubtitles, vSize: $vSize, aBitrate: $aBitrate, vFormat: $vFormat, aFormat: $aFormat}';
  }

  /// Default configuration
  static YtDlpConfig defaultConfig() {
    return const YtDlpConfig(
      ytUrl: "",
      dlVideo: true,
      dlAudio: false,
      dlThumbnail: false,
      dlSubtitles: false,
      vSize: VideoSize.v720p,
      aBitrate: AudioBitrate.a44k,
      vFormat: VideoFormat.mp4,
      aFormat: AudioFormat.mp3,
    );
  }

  /// State setters
  YtDlpConfig set({
    String? ytUrl,
    bool? dlVideo,
    bool? dlAudio,
    bool? dlThumbnail,
    bool? dlSubtitles,
    VideoSize? vSize,
    AudioBitrate? aBitrate,
    VideoFormat? vFormat,
    AudioFormat? aFormat,
  }) =>
      YtDlpConfig(
        ytUrl: ytUrl ?? this.ytUrl,
        dlVideo: dlVideo ?? this.dlVideo,
        dlAudio: dlAudio ?? this.dlAudio,
        dlThumbnail: dlThumbnail ?? this.dlThumbnail,
        dlSubtitles: dlSubtitles ?? this.dlSubtitles,
        vSize: vSize ?? this.vSize,
        aBitrate: aBitrate ?? this.aBitrate,
        vFormat: vFormat ?? this.vFormat,
        aFormat: aFormat ?? this.aFormat,
      );
}
