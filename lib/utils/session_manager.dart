import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../di/dependency_injection.dart';
import '../presentation/navigation/nav_routes.dart';

class SessionManager {
  final Ref ref;
  final int timeoutInSeconds;
  Timer? _timer;
  GlobalKey<NavigatorState>? _navigatorKey;
  final List<String> _excludedRoutes = [NavRoutes.landing, NavRoutes.login, NavRoutes.registration,];

  SessionManager({ required this.ref, this.timeoutInSeconds = 60 });

  void startSession(GlobalKey<NavigatorState>? navigatorKey, String? route) {
    _navigatorKey = navigatorKey;

    if (!_excludedRoutes.contains(route)) {
      _resetTimer();
      debugPrint("Session timer started for route: $route");
    } else {
      cancelTimer();
      debugPrint("Session timer cancelled or excluded for route: $route");
    }
  }

  void _resetTimer() {
    _timer?.cancel();
    _timer = Timer(Duration(seconds: timeoutInSeconds), _logout);
  }

  void handleUserActivity({String? route, bool isInteracting = false}) {
    if (route != null && !_excludedRoutes.contains(route)) {
      debugPrint('Session timer currently on:: handleUserActivity sessionManager');
      _resetTimer();
    } else if (isInteracting) {
      debugPrint('Session timer currently on:: handleUserActivity sessionManager else');
      _resetTimer();
    }
  }

  // void handleUserActivity(String? route) {
  //   if (route != null && !_excludedRoutes.contains(route)) {
  //     debugPrint('User is currently on:: handleUserActivity sessionManager');
  //     _resetTimer();
  //   }
  // }

  Future<void> _logout() async {
    final navigator = _navigatorKey?.currentState;
    if (navigator == null) return;

    final tokenManager = ref.read(tokenManagerProvider);
    final authManager = ref.read(authManagerProvider);
    await authManager?.logout();
    await tokenManager?.clearToken();

    if (navigator.mounted) {
      navigator.pushNamedAndRemoveUntil(NavRoutes.login, (route) => false, arguments: true);
    }
    _timer?.cancel();
    _timer = null;
  }

  void cancelTimer() {
    _timer?.cancel();
    _timer = null;
    _navigatorKey = null;
  }
}