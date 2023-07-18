import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// This class can be used to log changes to providers.
/// [isLoggingEnabled] can be set to false to turn off the logs.
class Logger extends ProviderObserver {
  final bool isLoggingEnabled;
  Logger({
    this.isLoggingEnabled = false,
  });
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (!isLoggingEnabled) return;
    log('''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "$newValue"
}''', name: 'app_states');
  }
}
