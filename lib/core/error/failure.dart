import 'exception.dart';

class Failure extends EmptyException {
  @override
  final String message;
  Failure({
    required this.message,
  }) : super(message: message);
}
