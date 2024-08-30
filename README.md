# Network Library

A lightweight network library for Dart and Flutter, designed to handle asynchronous operations and network requests with robust error handling.

## Features

- **Asynchronous Request Execution**: Provides methods for executing asynchronous operations with detailed error handling.
- **Network Requests**: Simplifies making network requests using Dio, handling various network-related exceptions.

## Dependencies

- [Dartz](https://pub.dev/packages/dartz): For functional programming utilities like `Either`.
- [Dio](https://pub.dev/packages/dio): For making network requests and handling responses.

## Setup

Add the following dependencies to your `pubspec.yaml`:

```yaml
dependencies:
  dartz: ^0.10.1
  dio: ^5.6.0
dev_dependencies:
  mocktail: ^1.0.4
```

## RequestExecuter

Handles asynchronous operations and maps exceptions to specific failure types.

### Example Usage

```dart
import 'package:dartz/dartz.dart';
import 'package:network/src/request_executer.dart';
import 'package:network/src/failures.dart';

void main() async {
  final requestExecuter = RequestExecuter();

  // Execute an async operation with error handling
  final result = await requestExecuter.executeWithError<String>(
    () async {
      // Simulate async operation
      return 'Success';
    },
  );

  result.fold(
    (failure) => print('Error: ${failure.title} - ${failure.message}'),
    (data) => print('Data: $data'),
  );

  // Execute an async operation that returns void
  try {
    await requestExecuter.executeVoid(() async {});
    print('Operation completed successfully');
  } catch (e) {
    if (e is Failure) {
      print('Error: ${e.title} - ${e.message}');
    } else {
      print('Unknown error occurred');
    }
  }
}
```

## NetworkService

Simplifies network requests and handles network-related exceptions using Dio.

### Example Usage

```dart
import 'package:dio/dio.dart';
import 'package:network/src/network_service.dart';
import 'package:network/src/exceptions.dart';

void main() async {
  final networkService = NetworkService();

  // Example of making a GET request
  try {
    final response = await networkService.get('/example', queryParameters: {'key': 'value'});
    print('Response data: ${response?.data}');
  } catch (e) {
    if (e is ConnectionTimeoutException) {
      print('Connection Timeout Error: ${e.message}');
    } else if (e is BadResponseException) {
      print('Bad Response Error: ${e.message}');
    } else {
      print('An unexpected error occurred: $e');
    }
  }

  // Example of making a POST request
  try {
    final response = await networkService.post('/submit', data: {'key': 'value'});
    print('Response data: ${response?.data}');
  } catch (e) {
    if (e is ConnectionTimeoutException) {
      print('Connection Timeout Error: ${e.message}');
    } else if (e is BadResponseException) {
      print('Bad Response Error: ${e.message}');
    } else {
      print('An unexpected error occurred: $e');
    }
  }
}
```
