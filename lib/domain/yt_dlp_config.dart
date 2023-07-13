class YtDlpConfig {
  final bool dlVideo;
  final bool dlAudio;
  final bool dlThumbnail;
  final bool dlSubtitles;

  /// Constructor
  const YtDlpConfig({
    required this.dlVideo,
    required this.dlAudio,
    required this.dlThumbnail,
    required this.dlSubtitles,
  });

  /// Default configuration
  static YtDlpConfig defaultConfig() {
    return const YtDlpConfig(
      dlVideo: true,
      dlAudio: false,
      dlThumbnail: false,
      dlSubtitles: false,
    );
  }

  /// State setters
  YtDlpConfig set({
    bool? dlVideo,
    bool? dlAudio,
    bool? dlThumbnail,
    bool? dlSubtitles,
  }) =>
      YtDlpConfig(
        dlVideo: dlVideo ?? this.dlVideo,
        dlAudio: dlAudio ?? this.dlAudio,
        dlThumbnail: dlThumbnail ?? this.dlThumbnail,
        dlSubtitles: dlSubtitles ?? this.dlSubtitles,
      );
}
