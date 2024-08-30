import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network/src/exceptions.dart';
import 'package:network/src/failures.dart';
import 'package:network/src/request_executer.dart';

void main() {
  late RequestExecuter requestExecuter;

  setUp(() {
    requestExecuter = RequestExecuter();
  });

  test(
      'executeWithError, ConnectionTimeoutException için ConnectionTimeoutFailure döndürmeli',
      () async {
    final result = await requestExecuter.executeWithError(
      () async => throw ConnectionTimeoutException(),
    );

    // Beklenen ve gerçek sonucu kontrol et
    expect(
        result,
        isA<Left<Failure, Never>>().having(
            (left) => left.value, 'value', isA<ConnectionTimeoutFailure>()));
  });
}
