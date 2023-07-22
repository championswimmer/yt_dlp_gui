import 'dart:convert';

sealed class DownloadState {}

class InitialDownloadState extends DownloadState {}

class DownloadingState extends DownloadState {
  final double progress;
  DownloadingState({
    required this.progress,
  });

  DownloadingState copyWith({
    double? progress,
  }) {
    return DownloadingState(
      progress: progress ?? this.progress,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'progress': progress,
    };
  }

  factory DownloadingState.fromMap(Map<String, dynamic> map) {
    return DownloadingState(
      progress: map['progress']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory DownloadingState.fromJson(String source) =>
      DownloadingState.fromMap(json.decode(source));

  @override
  String toString() => 'DownloadingState(progress: $progress)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DownloadingState && other.progress == progress;
  }

  @override
  int get hashCode => progress.hashCode;
}

class DownloadedState extends DownloadState {}

class DownloadErroState extends DownloadState {
  final String error;
  DownloadErroState({
    this.error = '',
  });

  DownloadErroState copyWith({
    String? error,
  }) {
    return DownloadErroState(
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'error': error,
    };
  }

  factory DownloadErroState.fromMap(Map<String, dynamic> map) {
    return DownloadErroState(
      error: map['error'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DownloadErroState.fromJson(String source) =>
      DownloadErroState.fromMap(json.decode(source));

  @override
  String toString() => 'DownloadErroState(error: $error)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DownloadErroState && other.error == error;
  }

  @override
  int get hashCode => error.hashCode;
}
