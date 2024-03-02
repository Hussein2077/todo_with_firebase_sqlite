abstract class Failure {
  final  String?  errorMessage ;

  Failure({this.errorMessage});
}
class ErrorMessageFailure extends Failure {

  ErrorMessageFailure({required String message}):super(errorMessage: message);
}
class ServerFailure extends Failure {}
class UnauthorizedFailure extends Failure {}
class InternetFailure extends Failure {}