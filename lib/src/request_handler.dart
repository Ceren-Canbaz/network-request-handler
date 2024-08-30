import 'package:dio/dio.dart';
import 'package:network/src/exceptions.dart';

/// [NetworkService] provides methods for making network requests using the Dio package
///
/// This class wraps the Dio HTTP client and provides methods for performing various tyoes of
/// HTTP requests such as [GET] [POST] [DELETE] [PUT] [PATCH].
/// It also includes error handling for common network related exceptions.
///
/// Example usage:
/// ```dart
/// final networkService = NetworkService();
///
/// try {
///   final response = await networkService.get('/example');
///   print(response.data);
/// } catch (e) {
///   print('An error occurred: $e');
/// }
/// ```
///
/// ## Constructor

/// NetworkService({Dio? dio});

/// The constructor accepts an optional `Dio` instance. If not provided, a new instance of Dio will be created.
///
/// ## Methods
/// ### `performRequest<T>(Future<T> Function() request)`
/// Executes a given network request and handles potential exceptions. It catches `DioException` types and maps them to custom exceptions defined in the `exceptions.dart` file.
///
/// #### Parameters
/// - `request`: A function that returns a `Future<T>`, representing the network request to be executed.
///
/// #### Returns
/// - A `Future<T>` representing the result of the network request.
///
/// #### Throws
/// - Various custom exceptions based on the `DioException` type:
///   - `ConnectionTimeoutException` for connection timeout errors.
///   - `SendTimeoutException` for send timeout errors.
///   - `ReceiveTimeoutException` for receive timeout errors.
///   - `BadCertificateException` for certificate validation errors.
///   - `BadResponseException` for invalid response errors.
///   - `CancelException` for cancelled requests.
///   - `ConnectionErrorException` for connection-related errors.
///   - `UnknownException` for unknown errors.
///
/// ### `get(String path, {Map<String, dynamic>? queryParameters})`
/// Sends an HTTP GET request to the specified path with optional query parameters.
///
/// #### Parameters
/// - `path`: The URL path for the GET request.
/// - `queryParameters`: Optional query parameters to be included in the request.
///
/// #### Returns
/// - A `Future<Response?>` representing the HTTP response.
///
/// ### `post(String path, {dynamic data, Map<String, dynamic>? queryParameters})`
/// Sends an HTTP POST request to the specified path with optional data and query parameters.
///
/// #### Parameters
/// - `path`: The URL path for the POST request.
/// - `data`: Optional data to be included in the request body.
/// - `queryParameters`: Optional query parameters to be included in the request.
///
/// #### Returns
/// - A `Future<Response?>` representing the HTTP response.
///
/// ### `put(String path, {dynamic data, Map<String, dynamic>? queryParameters})`
/// Sends an HTTP PUT request to the specified path with optional data and query parameters.
///
/// #### Parameters
/// - `path`: The URL path for the PUT request.
/// - `data`: Optional data to be included in the request body.
/// - `queryParameters`: Optional query parameters to be included in the request.
///
/// #### Returns
/// - A `Future<Response?>` representing the HTTP response.
///
/// ### `delete(String path, {dynamic data, Map<String, dynamic>? queryParameters})`
/// Sends an HTTP DELETE request to the specified path with optional data and query parameters.
///
/// #### Parameters
/// - `path`: The URL path for the DELETE request.
/// - `data`: Optional data to be included in the request body.
/// - `queryParameters`: Optional query parameters to be included in the request.
///
/// #### Returns
/// - A `Future<Response?>` representing the HTTP response.
///
/// ### `patch(String path, {dynamic data, Map<String, dynamic>? queryParameters})`
/// Sends an HTTP PATCH request to the specified path with optional data and query parameters.
///
/// #### Parameters
/// - `path`: The URL path for the PATCH request.
/// - `data`: Optional data to be included in the request body.
/// - `queryParameters`: Optional query parameters to be included in the request.
///
/// #### Returns
/// - A `Future<Response?>` representing the HTTP response.
///
/// ### `head(String path, {Map<String, dynamic>? queryParameters})`
/// Sends an HTTP HEAD request to the specified path with optional query parameters.
///
/// #### Parameters
/// - `path`: The URL path for the HEAD request.
/// - `queryParameters`: Optional query parameters to be included in the request.
///
/// #### Returns
/// - A `Future<Response?>` representing the HTTP response.
class NetworkService {
  final Dio _dio;

  NetworkService({Dio? dio}) : _dio = dio ?? Dio();

  Future<Response?> performRequest(Future<Response?> Function() request) async {
    try {
      final response = await request();
      return response;
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          throw ConnectionTimeoutException();
        case DioExceptionType.sendTimeout:
          throw SendTimeoutException();
        case DioExceptionType.receiveTimeout:
          throw ReceiveTimeoutException();
        case DioExceptionType.badCertificate:
          throw BadCertificateException();
        case DioExceptionType.badResponse:
          throw BadResponseException();
        case DioExceptionType.cancel:
          throw CancelException();
        case DioExceptionType.connectionError:
          throw ConnectionErrorException();
        case DioExceptionType.unknown:
          throw UnknownException();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  void _handleDioError(DioException error) {}

  Future<Response?> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    return performRequest(
        () => _dio.get(path, queryParameters: queryParameters));
  }

  Future<Response?> post(String path,
      {dynamic data, Map<String, dynamic>? queryParameters}) async {
    return performRequest(
        () => _dio.post(path, data: data, queryParameters: queryParameters));
  }

  Future<Response?> put(String path,
      {dynamic data, Map<String, dynamic>? queryParameters}) async {
    return performRequest(
        () => _dio.put(path, data: data, queryParameters: queryParameters));
  }

  Future<Response?> delete(String path,
      {dynamic data, Map<String, dynamic>? queryParameters}) async {
    return performRequest(
        () => _dio.delete(path, data: data, queryParameters: queryParameters));
  }

  Future<Response?> patch(String path,
      {dynamic data, Map<String, dynamic>? queryParameters}) async {
    return performRequest(
        () => _dio.patch(path, data: data, queryParameters: queryParameters));
  }

  Future<Response?> head(String path,
      {Map<String, dynamic>? queryParameters}) async {
    return performRequest(
        () => _dio.head(path, queryParameters: queryParameters));
  }
}
