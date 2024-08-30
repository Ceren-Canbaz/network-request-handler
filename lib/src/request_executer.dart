import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:network/src/exceptions.dart';
import 'package:network/src/failures.dart';

/// A class responsible for executing asynchronous requests and handling exceptions.
///
/// The `RequestExecuter` class provides methods to execute asynchronous operations and handle
/// exceptions by mapping them to appropriate failure or error types. It supports handling
/// different kinds of network and general errors.
///
/// ## Methods
/// ### `executeWithError<T>(Future<T> Function() sourceCall)`
/// Executes an asynchronous operation and returns an `Either` type that wraps either a `Failure`
/// or the result of the operation. It maps specific exceptions to corresponding failure types.
///
/// #### Parameters
/// - `sourceCall`: A function that returns a `Future<T>`, representing the asynchronous operation
///   to be executed.
///
/// #### Returns
/// - `Future<Either<Failure, T>>`: A `Future` that resolves to an `Either` containing either a `Failure`
///   (if an exception occurred) or the result of type `T` (if the operation was successful).
///
/// #### Throws
/// - The method itself does not throw exceptions, but it returns failures wrapped in the `Left` side
///   of the `Either` if an error occurs.
///
/// ### `executeVoid(Future<void> Function() sourceCall)`
/// Executes an asynchronous operation that returns `void` and handles exceptions by throwing
/// appropriate failure types.
///
/// #### Parameters
/// - `sourceCall`: A function that returns a `Future<void>`, representing the asynchronous operation
///   to be executed.
///
/// #### Returns
/// - `Future<void>`: A `Future` that completes when the operation is done.
///
/// #### Throws
/// - Various failure types based on the exception encountered:
///   - `ConnectionTimeoutFailure` for connection timeout errors.
///   - `SendTimeoutFailure` for send timeout errors.
///   - `ReceiveTimeoutFailure` for receive timeout errors.
///   - `BadCertificateFailure` for certificate validation errors.
///   - `BadResponseFailure` for invalid response errors.
///   - `CancelFailure` for cancelled operations.
///   - `ConnectionErrorFailure` for connection-related errors.
///   - `UnknownFailure` for unknown errors.
///
/// ### `executeWithoutError<T>(Future<T> Function() sourceCall)`
/// Executes an asynchronous operation and returns the result, or throws an exception if an error occurs.
///
/// #### Parameters
/// - `sourceCall`: A function that returns a `Future<T>`, representing the asynchronous operation
///   to be executed.
///
/// #### Returns
/// - `Future<T>`: A `Future` that resolves to the result of type `T` if the operation is successful.
///
/// #### Throws
/// - Various failure types based on the exception encountered:
///   - `ConnectionTimeoutFailure` for connection timeout errors.
///   - `SendTimeoutFailure` for send timeout errors.
///   - `ReceiveTimeoutFailure` for receive timeout errors.
///   - `BadCertificateFailure` for certificate validation errors.
///   - `BadResponseFailure` for invalid response errors.
///   - `CancelFailure` for cancelled operations.
///   - `ConnectionErrorFailure` for connection-related errors.
///   - `UnknownFailure` for unknown errors.
///
/// The `RequestExecuter` class is designed to simplify error handling in asynchronous operations
/// by mapping different types of exceptions to well-defined failure types, making it easier to
/// handle errors consistently across the application.
class RequestExecuter {
  Future<Either<Failure, T>> executeWithError<T>(
    Future<T> Function() sourceCall,
  ) async {
    try {
      final T response = await sourceCall();
      return Right(response);
    } catch (e) {
      if (e is ConnectionTimeoutException) {
        return Left(ConnectionTimeoutFailure());
      } else if (e is SendTimeoutException) {
        return Left(SendTimeoutFailure());
      } else if (e is ReceiveTimeoutException) {
        return Left(ReceiveTimeoutFailure());
      } else if (e is BadCertificateException) {
        return Left(BadCertificateFailure());
      } else if (e is BadResponseException) {
        return Left(BadResponseFailure());
      } else if (e is CancelException) {
        return Left(CancelFailure());
      } else if (e is ConnectionErrorException) {
        return Left(ConnectionErrorFailure());
      } else if (e is UnknownException) {
        return Left(UnknownFailure());
      } else {
        return Left(UnknownFailure());
      }
    }
  }

  Future<void> executeVoid(
    Future<void> Function() sourceCall,
  ) async {
    try {
      await sourceCall();
    } catch (e) {
      if (e is ConnectionTimeoutException) {
        throw ConnectionTimeoutFailure();
      } else if (e is SendTimeoutException) {
        throw SendTimeoutFailure();
      } else if (e is ReceiveTimeoutException) {
        throw ReceiveTimeoutFailure();
      } else if (e is BadCertificateException) {
        throw BadCertificateFailure();
      } else if (e is BadResponseException) {
        throw BadResponseFailure();
      } else if (e is CancelException) {
        throw CancelFailure();
      } else if (e is ConnectionErrorException) {
        throw ConnectionErrorFailure();
      } else if (e is UnknownException) {
        throw UnknownFailure();
      } else {
        throw UnknownFailure();
      }
    }
  }

  Future<T> executeWithoutError<T>(
    Future<T> Function() sourceCall,
  ) async {
    try {
      final T response = await sourceCall();
      return response;
    } catch (e) {
      if (e is ConnectionTimeoutException) {
        throw ConnectionTimeoutFailure();
      } else if (e is SendTimeoutException) {
        throw SendTimeoutFailure();
      } else if (e is ReceiveTimeoutException) {
        throw ReceiveTimeoutFailure();
      } else if (e is BadCertificateException) {
        throw BadCertificateFailure();
      } else if (e is BadResponseException) {
        throw BadResponseFailure();
      } else if (e is CancelException) {
        throw CancelFailure();
      } else if (e is ConnectionErrorException) {
        throw ConnectionErrorFailure();
      } else if (e is UnknownException) {
        throw UnknownFailure();
      } else {
        throw UnknownFailure();
      }
    }
  }
}
