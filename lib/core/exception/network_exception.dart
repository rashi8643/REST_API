import 'package:rest_api_employee/core/exception/base_exception.dart';

class NetworkException extends BaseException {
  final String? error;
  NetworkException({this.error})
      : super(message: error ?? "Bad network, please try again");
}
