class ApiResponse<T> {
  final T? data;
  final String? error;

  ApiResponse({this.data, this.error});

  bool get isSuccess => error == null;

  factory ApiResponse.success(T data) => ApiResponse(data: data);

  factory ApiResponse.failure(String error) => ApiResponse(error: error);
}
