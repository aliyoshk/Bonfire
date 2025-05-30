import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/factory/service_factory.dart';
import '../data/api/api_client.dart';
import '../data/local/auth/auth_manager_impl.dart';
import '../data/local/datasource/auth_interceptor.dart';
import '../data/local/datasource/token_manager.dart';
import '../data/services/implementation/auth_repository_impl.dart';
import '../data/services/implementation/payment_repository_impl.dart';
import '../data/services/mock/mock_auth_repository.dart';
import '../data/services/mock/mock_payment_repository.dart';
import '../data/services/mock/mock_registration_repository.dart';
import '../data/services/implementation/registration_repository_impl.dart';
import '../data/services/repositories/auth_repository.dart';
import '../data/services/repositories/payment_repository.dart';
import '../data/services/repositories/registration_repository.dart';
import '../data/services/mock/mock_transaction_repository.dart';
import '../data/services/implementation/transaction_repository_impl.dart';
import '../data/services/repositories/transaction_repository.dart';
import '../domain/auth/auth_manager.dart';
import '../domain/usecases/auth_usecases.dart';
import '../domain/usecases/payment_usecases.dart';
import '../domain/usecases/registration_usecases.dart';
import '../domain/usecases/transaction_usecases.dart';
import '../utils/session_manager.dart';


final serviceFactoryProvider = ChangeNotifierProvider<ServiceFactory>((ref) => ServiceFactory());

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs;
});

final sessionManagerProvider = Provider<SessionManager>((ref) {
  return SessionManager(ref: ref);
});

final navigatorKeyProvider = Provider<GlobalKey<NavigatorState>>((ref) {
  return GlobalKey<NavigatorState>();
});

final tokenManagerProvider = Provider<TokenManager?>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return sharedPreferences.when(
    data: (data) => TokenManager(data),
    error: (error, stackTrace) => throw error,
    loading: () => null,
  );
});

final authManagerProvider = Provider<AuthManager?>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return sharedPreferences.when(
    data: (data) => AuthManagerImpl(data),
    error: (error, stackTrace) => throw error,
    loading: () => null,
  );
});

final authInterceptorProvider = Provider.autoDispose<AuthInterceptor>((ref) {
  final tokenManager = ref.watch(tokenManagerProvider);
  if (tokenManager == null) {
    throw Exception("TokenManager not available");
  }
  return AuthInterceptor(tokenManager);
});

final dioProvider = Provider<Dio>((ref) {
  final authInterceptor = ref.watch(authInterceptorProvider);
  return Dio()..interceptors.add(authInterceptor);
});

final apiClientProvider = Provider<ApiClient>((ref) {
  ref.watch(sharedPreferencesProvider);
  final dio = ref.watch(dioProvider);
  final useMock = ref.watch(serviceFactoryProvider).useMockData;

  // final String baseUrl = useMock
  //     ? ''
  //     : 'https://ice-care-mobile-backend-d5fwe4asg9cwbnbd.southafricanorth-01.azurewebsites.net/api/';
  final String baseUrl = useMock
      ? ''
      : 'https://icecarebackend-g6bshpdjcdhyepde.southafricanorth-01.azurewebsites.net/api/';

  return ApiClient(dio: dio, baseUrl: baseUrl);
});
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final useMock = ref.watch(serviceFactoryProvider).useMockData;
  final apiClient = ref.watch(apiClientProvider);
  final tokenManager = ref.watch(tokenManagerProvider);
  return useMock? MockAuthRepository() : AuthRepositoryImpl(apiClient, tokenManager!);
});
final paymentRepositoryProvider = Provider<PaymentRepository>((ref){
  final useMock = ref.watch(serviceFactoryProvider).useMockData;
  final apiClient = ref.watch(apiClientProvider);

  return useMock? MockPaymentRepository() : PaymentRepositoryImpl(apiClient);
});

final registrationRepositoryProvider = Provider<RegistrationRepository>((ref){
  final useMock = ref.watch(serviceFactoryProvider).useMockData;
  final apiClient = ref.watch(apiClientProvider);

  return useMock ? MockRegistrationRepository() : RegistrationRepositoryImpl(apiClient);
});
final transactionRepositoryProvider = Provider<TransactionRepository>((ref){
  final useMock = ref.watch(serviceFactoryProvider).useMockData;
  final apiClient = ref.watch(apiClientProvider);
  return useMock? MockTransactionRepository() : TransactionRepositoryImpl(apiClient);
});

// UseCases
final loginUseCaseProvider = Provider.autoDispose<LoginUseCase>((ref) {
  ref.watch(sharedPreferencesProvider);
  final authRepository = ref.watch(authRepositoryProvider);
  final authManager = ref.watch(authManagerProvider);
  if (authManager == null) {
    throw Exception("AuthManager not available");
  }
  return LoginUseCase(authRepository, authManager);
});

final refreshAccountUseCaseProvider = Provider<RefreshAccountUseCase>((ref) {
  ref.watch(sharedPreferencesProvider);
  final repository = ref.watch(authRepositoryProvider);
  final authManager = ref.watch(authManagerProvider);
  if (authManager == null) {
    throw Exception("AuthManager not available");
  }
  return RefreshAccountUseCase(repository, authManager);
});
final transferUseCaseProvider = Provider<TransferUseCase>((ref) {
  ref.watch(sharedPreferencesProvider);
  final repository = ref.watch(paymentRepositoryProvider);
  return TransferUseCase(repository);
});
final accountTransferUseCaseProvider = Provider<AccountTransferUseCase>((ref) {
  ref.watch(sharedPreferencesProvider);
  final repository = ref.watch(paymentRepositoryProvider);
  return AccountTransferUseCase(repository);
});
final thirdPartyTransferUseCaseProvider = Provider<ThirdPartyTransferUseCase>((ref) {
  ref.watch(sharedPreferencesProvider);
  final repository = ref.watch(paymentRepositoryProvider);
  return ThirdPartyTransferUseCase(repository);
});
final accountTopUpUseCaseProvider = Provider<AccountTopUpUseCase>((ref) {
  ref.watch(sharedPreferencesProvider);
  final repository = ref.watch(paymentRepositoryProvider);
  return AccountTopUpUseCase(repository);
});
final registrationUseCaseProvider = Provider<RegistrationUseCase>((ref) {
  ref.watch(sharedPreferencesProvider);
  final repository = ref.watch(registrationRepositoryProvider);
  return RegistrationUseCase(repository);
});
final getTransferStatusUseCaseProvider = Provider<GetTransferStatusUseCase>((ref) {
  ref.watch(sharedPreferencesProvider);
  final repository = ref.watch(transactionRepositoryProvider);
  return GetTransferStatusUseCase(repository);
});
final getHistoryUseCaseProvider = Provider<GetTransactionHistoryUseCase>((ref) {
  ref.watch(sharedPreferencesProvider);
  final repository = ref.watch(transactionRepositoryProvider);
  return GetTransactionHistoryUseCase(repository);
});