/// VideoSize
///   enum for video sizes:
///   144p, 240p, 360p, 480p, 720p, 1080p, 1440p, 2160p
enum VideoSize implements Comparable<VideoSize> {
  v144p(144),
  v240p(240),
  v360p(360),
  v480p(480),
  v720p(720),
  v1080p(1080),
  v1440p(1440),
  v2160p(2160);

  final int value;

  const VideoSize(this.value);

  @override
  int compareTo(VideoSize other) => value.compareTo(other.value);
}

/// VideoFormat
///  enum for video formats:
///  mp4, webm, 3gp
enum VideoFormat {
  mp4("mp4"),
  webm("webm"),
  threegp("3gp");

  final String value;
  const VideoFormat(this.value);

}

/// AudioFormat
/// enum for audio formats:
/// mp3, m4a, flac
enum AudioFormat {
  mp3("mp3"),
  m4a("m4a"),
  flac("flac");

  final String value;
  const AudioFormat(this.value);
}

/// AudioBitrate
///  enum for audio bitrates:
///  22k, 24k, 32k, 44k, 48k, 64k, 96k, 128k, 160k, 192k, 256k
enum AudioBitrate implements Comparable<AudioBitrate> {
  a22k(22),
  a24k(24),
  a32k(32),
  a44k(44),
  a48k(48),
  a64k(64),
  a96k(96),
  a128k(128),
  a160k(160),
  a192k(192),
  a256k(256);

  final int value;

  const AudioBitrate(this.value);

  @override
  int compareTo(AudioBitrate other) => value.compareTo(other.value);
}

