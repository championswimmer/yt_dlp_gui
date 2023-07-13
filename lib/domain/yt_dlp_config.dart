class YtDlpConfig {
  final String ytUrl;
  final bool dlVideo;
  final bool dlAudio;
  final bool dlThumbnail;
  final bool dlSubtitles;

  /// Constructor
  const YtDlpConfig({
    required this.ytUrl,
    required this.dlVideo,
    required this.dlAudio,
    required this.dlThumbnail,
    required this.dlSubtitles,
  });


  @override
  String toString() {
    return 'YtDlpConfig{ytUrl: $ytUrl, dlVideo: $dlVideo, dlAudio: $dlAudio, dlThumbnail: $dlThumbnail, dlSubtitles: $dlSubtitles}';
  }

  /// Default configuration
  static YtDlpConfig defaultConfig() {
    return const YtDlpConfig(
      ytUrl: "",
      dlVideo: true,
      dlAudio: false,
      dlThumbnail: false,
      dlSubtitles: false,
    );
  }

  /// State setters
  YtDlpConfig set({
    String? ytUrl,
    bool? dlVideo,
    bool? dlAudio,
    bool? dlThumbnail,
    bool? dlSubtitles,
  }) =>
      YtDlpConfig(
        ytUrl: ytUrl ?? this.ytUrl,
        dlVideo: dlVideo ?? this.dlVideo,
        dlAudio: dlAudio ?? this.dlAudio,
        dlThumbnail: dlThumbnail ?? this.dlThumbnail,
        dlSubtitles: dlSubtitles ?? this.dlSubtitles,
      );
}
