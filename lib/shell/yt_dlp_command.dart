
import 'package:yt_dlp_gui/domain/yt_dlp_config.dart';

class YtDlpCommand {
  final YtDlpConfig _config;

  YtDlpCommand(this._config);

  String buildCommand() {
    StringBuffer command = StringBuffer();
    if (_config.dlVideo) command.write(" -k");
    if (_config.dlAudio) command.write(" -x");
    if (_config.dlSubtitles) command.write(" --write-subs");
    if (_config.dlThumbnail) command.write(" --write-thumbnail");

    command.write(" ${_config.ytUrl}");

    return command.toString();
  }
}