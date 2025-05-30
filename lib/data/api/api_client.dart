import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'api_response.dart';
import 'dart:convert';

class ApiClient {
  final Dio dio;
  final String baseUrl;

  // ApiClient({required this.dio, required this.baseUrl});
  ApiClient({required this.dio, required this.baseUrl}) {
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    dio.options.headers = {'Content-Type': 'application/json'};
  }

  Future<ApiResponse<T>> get<T>(
      String endpoint, {
        Map<String, dynamic>? queryParams,
        required T Function(dynamic) fromJson,
      }) async {
    try {
      final url = '$baseUrl$endpoint';
      final response = await dio.get(url, queryParameters: queryParams);
      return ApiResponse.success(fromJson(response.data));
    } on DioException catch (e) {
      String errorMessage = '$e';
      try {
        if (e.response != null) {
          final jsonData = jsonDecode('${e.response}');
          errorMessage = jsonData['message'] ?? jsonData['errors'] ?? errorMessage;
        } else {
          errorMessage = e.message ?? e.toString();
        }
      }
      catch(jsonError) {
        errorMessage = jsonError.toString();
      }
      return ApiResponse.failure(errorMessage);
    } catch (e) {
      return ApiResponse.failure('Unexpected error occurred: $e');
    }
  }

  Future<ApiResponse<T>> post<T>(String endpoint, dynamic body, T Function(dynamic) fromJson,) async {
    debugPrint("The error we are facing is response baseUrl endpoint '$baseUrl$endpoint'");
    debugPrint("The error we are facing is response baseUrl $baseUrl");
    try {
      final url = '$baseUrl$endpoint';
      final response = await dio.post(url, data: body);
      debugPrint("The error we are facing is response baseUrl $baseUrl");
      debugPrint("The error we are facing is response $response");
      return ApiResponse.success(fromJson(response.data));
    } on DioException catch (e) {
      String errorMessage = '$e';
      debugPrint("The error we are facing is errorMessage eeeeee $e");
      debugPrint("The error we are facing is errorMessage eeeeee ${e.response}");
      try {
        if (e.response?.data != null) {
          final jsonData = jsonDecode('${e.response}');
          errorMessage = jsonData['message'] ?? jsonData['errors'] ?? errorMessage;
          debugPrint("The error we are facing is errorMessage $errorMessage");
        } else {
          errorMessage = e.message ?? e.toString();
          debugPrint("The error we are facing is else errorMessage $errorMessage");
        }
      }
      catch(jsonError) {
        errorMessage = jsonError.toString();
        debugPrint("The error we are facing is catch errorMessage $errorMessage");
      }
      debugPrint("The error we are facing is outer errorMessage $errorMessage");
      return ApiResponse.failure(errorMessage);
    } catch (e) {
      debugPrint("The error we are facing is catch errorMessage $e");
      return ApiResponse.failure('Unexpected error occurred: $e');
    }
  }
  // Future<ApiResponse<T>> post<T>(String endpoint, dynamic body, T Function(dynamic) fromJson,) async {
  //   try {
  //     final url = '$baseUrl$endpoint';
  //     final response = await dio.post(url, data: body);
  //     if (response.statusCode == 200) {
  //       final data = response.data;
  //       return ApiResponse.success(fromJson(data));
  //     } else {
  //       String errorMessage = 'Error: ${response.statusCode} ${response.statusMessage}';
  //       if (response.data != null) {
  //         try {
  //           final jsonData = jsonDecode(response.data.toString());
  //           errorMessage = jsonData['message'] ?? errorMessage;
  //           debugPrint('Failed to parse JSON error error try block');
  //           debugPrint('Failed to parse JSON error in DioError jsonData: $errorMessage');
  //         } catch (e) {
  //           debugPrint('Failed to parse JSON error error catch block');
  //           debugPrint('Failed to parse JSON error: $e');
  //         }
  //       }
  //       debugPrint('Failed to parse JSON error error outer block');
  //       debugPrint('Failed to parse JSON error in DioError errorMessage: ${errorMessage.toString()}');
  //       return ApiResponse.failure(errorMessage);
  //     }
  //   } on DioException catch (e) {
  //     String errorMessage = '$e';
  //     if (e.response?.data != null) {
  //       try {
  //         debugPrint('Failed to parse JSON error Dio try block');
  //         final jsonData = jsonDecode(e.response!.data.toString());
  //         errorMessage = jsonData['message'] ?? jsonData['error'] ?? errorMessage;
  //         debugPrint('Failed to parse JSON error in DioError jsonData: $errorMessage');
  //       } catch (jsonError) {
  //         debugPrint('Failed to parse JSON error Dio catch block');
  //         debugPrint('Failed to parse JSON error in DioError: $jsonError');
  //         debugPrint('Failed to parse JSON error in DioError: $errorMessage');
  //         debugPrint('Failed to parse JSON error in DioError: ${e.response?.data.toString()}');
  //         errorMessage = e.response?.data.toString() ?? errorMessage;
  //       }
  //     }
  //     debugPrint('Failed to parse JSON error Dio outer block');
  //     debugPrint('Failed to parse JSON error in DioError: errorMessage ${e.message}');
  //     return ApiResponse.failure(errorMessage);
  //   } catch (e) {
  //     debugPrint('Failed to parse JSON error in DioError: catch $e');
  //     return ApiResponse.failure('Unexpected error occurred: $e');
  //   }
  // }

  Future<ApiResponse<T>> put<T>(String endpoint, Map<String, dynamic> body, T Function(dynamic) fromJson,) async {
    try {
      final url = '$baseUrl$endpoint';
      final response = await dio.put(url, data: body);
      return ApiResponse.success(fromJson(response.data));
    } on DioException catch (e) {
      String errorMessage = '$e';
      try {
        if (e.response != null) {
          final jsonData = jsonDecode('${e.response}');
          errorMessage = jsonData['message'] ?? jsonData['errors'] ?? errorMessage;
        } else {
          errorMessage = e.message ?? e.toString();
        }
      }
      catch(jsonError) {
        errorMessage = jsonError.toString();
      }
      return ApiResponse.failure(errorMessage);
    } catch (e) {
      return ApiResponse.failure('Unexpected error occurred: $e');
    }
  }

  Future<ApiResponse<void>> delete(String endpoint) async {
    try {
      final url = '$baseUrl$endpoint';
      final response = await dio.delete(url);
      if (response.statusCode == 200) {
        return ApiResponse.success(null);
      } else {
        String errorMessage = 'Error: ${response.statusCode} ${response.statusMessage}';
        if (response.data != null) {
          try {
            final jsonData = jsonDecode(response.data.toString());
            errorMessage = jsonData['message'] ?? errorMessage;
          } catch (e) {
            debugPrint('Failed to parse JSON error: $e');
          }
        }
        return ApiResponse.failure(errorMessage);
      }
    } on DioException catch (e) {
      String errorMessage = '$e';
      if (e.response?.data != null) {
        try {
          final jsonData = jsonDecode(e.response!.data.toString());
          errorMessage = jsonData['message'] ?? jsonData['error'] ?? errorMessage;
        } catch (jsonError) {
          debugPrint('Failed to parse JSON error in DioError: $jsonError');
          errorMessage = e.response?.data.toString() ?? errorMessage;
        }
      }
      return ApiResponse.failure(errorMessage);
    } catch (e) {
      return ApiResponse.failure('Unexpected error occurred: $e');
    }
  }
}