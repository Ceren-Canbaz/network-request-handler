abstract class Failure {
  final String title;
  final String message;

  Failure({required this.title, required this.message});
}

class ConnectionTimeoutFailure extends Failure {
  ConnectionTimeoutFailure({super.message = 'Connection timed out.'})
      : super(title: 'Connection Timeout');
}

class SendTimeoutFailure extends Failure {
  SendTimeoutFailure({super.message = 'Send request timed out.'})
      : super(title: 'Send Timeout');
}

class ReceiveTimeoutFailure extends Failure {
  ReceiveTimeoutFailure({super.message = 'Receive response timed out.'})
      : super(title: 'Receive Timeout');
}

class BadCertificateFailure extends Failure {
  BadCertificateFailure({super.message = 'Bad certificate received.'})
      : super(title: 'Bad Certificate');
}

class BadResponseFailure extends Failure {
  BadResponseFailure(
      {super.message = 'Bad response received from server.', int? statusCode})
      : super(title: 'Bad Response');
}

class CancelFailure extends Failure {
  CancelFailure({super.message = 'Request was cancelled.'})
      : super(title: 'Request Cancelled');
}

class ConnectionErrorFailure extends Failure {
  ConnectionErrorFailure({super.message = 'Connection error occurred.'})
      : super(title: 'Connection Error');
}

class UnknownFailure extends Failure {
  UnknownFailure({super.message = 'Unknown error occurred.'})
      : super(title: 'Unknown Error');
}
