import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:network/network.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late NetworkService networkService;

  setUp(() {
    mockDio = MockDio();
    networkService = NetworkService(dio: mockDio);
  });

  group('NetworkService', () {
    test(
        'should throw ConnectionTimeoutException for DioExceptionType.connectionTimeout',
        () async {
      when(() => mockDio.get(any())).thenThrow(
        DioException(
          type: DioExceptionType.connectionTimeout,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      expect(
        () async => await networkService.get('/test'),
        throwsA(isA<ConnectionTimeoutException>()),
      );
    });

    test('should throw SendTimeoutException for DioExceptionType.sendTimeout',
        () async {
      when(() => mockDio.post(any())).thenThrow(
        DioException(
          type: DioExceptionType.sendTimeout,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      expect(
        () async => await networkService.post('/test'),
        throwsA(isA<SendTimeoutException>()),
      );
    });

    test(
        'should throw ReceiveTimeoutException for DioExceptionType.receiveTimeout',
        () async {
      when(() => mockDio.put(any())).thenThrow(
        DioException(
          type: DioExceptionType.receiveTimeout,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      expect(
        () async => await networkService.put('/test'),
        throwsA(isA<ReceiveTimeoutException>()),
      );
    });

    test(
        'should throw BadCertificateException for DioExceptionType.badCertificate',
        () async {
      when(() => mockDio.delete(any())).thenThrow(
        DioException(
          type: DioExceptionType.badCertificate,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      expect(
        () async => await networkService.delete('/test'),
        throwsA(isA<BadCertificateException>()),
      );
    });

    test('should throw BadResponseException for DioExceptionType.badResponse',
        () async {
      when(() => mockDio.patch(any())).thenThrow(
        DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      expect(
        () async => await networkService.patch('/test'),
        throwsA(isA<BadResponseException>()),
      );
    });

    test('should throw CancelException for DioExceptionType.cancel', () async {
      when(() => mockDio.head(any())).thenThrow(
        DioException(
          type: DioExceptionType.cancel,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      expect(
        () async => await networkService.head('/test'),
        throwsA(isA<CancelException>()),
      );
    });

    test(
        'should throw ConnectionErrorException for DioExceptionType.connectionError',
        () async {
      when(() => mockDio.get(any())).thenThrow(
        DioException(
          type: DioExceptionType.connectionError,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      expect(
        () async => await networkService.get('/test'),
        throwsA(isA<ConnectionErrorException>()),
      );
    });

    test('should throw UnknownException for DioExceptionType.unknown',
        () async {
      when(() => mockDio.get(any())).thenThrow(
        DioException(
          type: DioExceptionType.unknown,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      expect(
        () async => await networkService.get('/test'),
        throwsA(isA<UnknownException>()),
      );
    });

    test('should throw Exception for other errors', () async {
      when(() => mockDio.get(any())).thenThrow(Exception('Unknown error'));

      expect(
        () async => await networkService.get('/test'),
        throwsA(isA<Exception>()),
      );
    });
  });
}
