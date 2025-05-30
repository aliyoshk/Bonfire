import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ice_care_mobile/data/models/request/login_request.dart';
import 'package:ice_care_mobile/data/models/response/login_response.dart';
import 'package:ice_care_mobile/domain/usecases/auth_usecases.dart';
import '../../di/dependency_injection.dart';

class AuthViewModel extends StateNotifier<AsyncValue<dynamic>> {
  final LoginUseCase? _loginUseCase;
  final RefreshAccountUseCase? _refreshAccountUseCase;

  AuthViewModel(this._loginUseCase, this._refreshAccountUseCase) : super(const AsyncValue.loading());

  Future<void> login(LoginRequest loginRequest) async {
    state = const AsyncValue.loading();
    if (_loginUseCase == null) {
      state = AsyncValue.error("Login Use case not initialized", StackTrace.current);
      return;
    }
    final response = await _loginUseCase.execute(loginRequest);
    if (response.isSuccess) {
      state = AsyncValue.data(response.data!);
    } else {
      state = AsyncValue.error(response.error!, StackTrace.current);
    }
  }

  Future<void> refreshAccount(String email) async {
    state = const AsyncValue.loading();
    if (_refreshAccountUseCase == null) {
      state = AsyncValue.error("Refresh Use case not initialized", StackTrace.current);
      return;
    }
    final response = await _refreshAccountUseCase.execute(email);
    if (response.isSuccess) {
      state = AsyncValue.data(response.data);
    } else {
      state = AsyncValue.error(response.error ?? 'Refresh failed', StackTrace.current);
    }
  }
}

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AsyncValue<dynamic>>((ref) {
  final loginUseCase = ref.watch(loginUseCaseProvider);
  final refreshAccountUseCase = ref.watch(refreshAccountUseCaseProvider);
  return AuthViewModel(loginUseCase, refreshAccountUseCase);
});