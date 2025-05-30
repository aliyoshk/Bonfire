import 'dart:async';

class SessionManager {
  final int timeoutInSeconds;
  Timer? _timer;
  final void Function()? onSessionTimeout;

  SessionManager({
    required this.timeoutInSeconds,
    required this.onSessionTimeout,
  });

  void startSession() {
    _resetTimer();
  }

  void userActivityDetected() {
    _resetTimer();
  }

  void _resetTimer() {
    _timer?.cancel();
    _timer = Timer(Duration(seconds: timeoutInSeconds), () {
      _timer = null;
      onSessionTimeout?.call();
    });
  }

  void cancelSession() {
    _timer?.cancel();
    _timer = null;
  }
}
