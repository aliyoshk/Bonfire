import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/service_factory.dart';
import '../data/api/api_client.dart';
import '../data/local/datasource/auth_interceptor.dart';
import '../data/local/datasource/token_manager.dart';


final serviceFactoryProvider = ChangeNotifierProvider<ServiceFactory>((ref) => ServiceFactory());

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs;
});


final tokenManagerProvider = Provider<TokenManager?>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return sharedPreferences.when(
    data: (data) => TokenManager(data),
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

  final String baseUrl = useMock
      ? ''
      : 'https://icecarebackend-g6bshpdjcdhyepde.southafricanorth-01.azurewebsites.net/api/';

  return ApiClient(dio: dio, baseUrl: baseUrl);
});

// Providers
// final transactionRepositoryProvider = Provider<TransactionRepository>((ref){
//   final useMock = ref.watch(serviceFactoryProvider).useMockData;
//   final apiClient = ref.watch(apiClientProvider);
//   return useMock? MockTransactionRepository() : TransactionRepositoryImpl(apiClient);
// });

// UseCases
// final getHistoryUseCaseProvider = Provider<GetTransactionHistoryUseCase>((ref) {
//   ref.watch(sharedPreferencesProvider);
//   final repository = ref.watch(transactionRepositoryProvider);
//   return GetTransactionHistoryUseCase(repository);
// });