import 'package:yt_dlp_gui/domain/yt_dlp_config_enums.dart';

/// YtDlpConfig
/// [ytUrl] - YouTube URL
/// [dlVideo] - Download video flag
/// [dlAudio] - Download audio flag
/// [dlThumbnail] - Download thumbnail flag
/// [dlSubtitles] - Download subtitles flag
/// [sponsorBlock] - SponsorBlock flag
class YtDlpConfig {
  final String ytUrl;

  final String? startTime;
  final String? endTime;

  final bool dlVideo;
  final bool dlAudio;
  final bool dlThumbnail;
  final bool dlSubtitles;

  final VideoSize vSize;
  final AudioBitrate aBitrate;

  final VideoFormat vFormat;
  final AudioFormat aFormat;

  final bool sponsorBlock;

  /// Constructor
  const YtDlpConfig({
    required this.ytUrl,
    required this.startTime,
    required this.endTime,
    required this.dlVideo,
    required this.dlAudio,
    required this.dlThumbnail,
    required this.dlSubtitles,
    required this.vSize,
    required this.aBitrate,
    required this.vFormat,
    required this.aFormat,
    required this.sponsorBlock,
  });

  @override
  String toString() {
    return 'YtDlpConfig{ytUrl: $ytUrl, startTime: $startTime, endTime: $endTime, dlVideo: $dlVideo, dlAudio: $dlAudio, dlThumbnail: $dlThumbnail, dlSubtitles: $dlSubtitles, vSize: $vSize, aBitrate: $aBitrate, vFormat: $vFormat, aFormat: $aFormat}';
  }

  /// Default configuration
  static YtDlpConfig defaultConfig() {
    return const YtDlpConfig(
      ytUrl: "",
      startTime: null,
      endTime: null,
      dlVideo: true,
      dlAudio: false,
      dlThumbnail: false,
      dlSubtitles: false,
      vSize: VideoSize.v720p,
      aBitrate: AudioBitrate.a44k,
      vFormat: VideoFormat.mp4,
      aFormat: AudioFormat.mp3,
      sponsorBlock: false,
    );
  }

  /// State setters
  YtDlpConfig set({
    String? ytUrl,
    String? startTime,
    String? endTime,
    bool? dlVideo,
    bool? dlAudio,
    bool? dlThumbnail,
    bool? dlSubtitles,
    VideoSize? vSize,
    AudioBitrate? aBitrate,
    VideoFormat? vFormat,
    AudioFormat? aFormat,
    bool? sponsorBlock,
  }) =>
      YtDlpConfig(
        ytUrl: ytUrl ?? this.ytUrl,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        dlVideo: dlVideo ?? this.dlVideo,
        dlAudio: dlAudio ?? this.dlAudio,
        dlThumbnail: dlThumbnail ?? this.dlThumbnail,
        dlSubtitles: dlSubtitles ?? this.dlSubtitles,
        vSize: vSize ?? this.vSize,
        aBitrate: aBitrate ?? this.aBitrate,
        vFormat: vFormat ?? this.vFormat,
        aFormat: aFormat ?? this.aFormat,
        sponsorBlock: sponsorBlock ?? this.sponsorBlock,
      );
}
