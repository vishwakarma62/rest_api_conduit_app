// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}
class LoginsubmitEvent extends LoginEvent {
  AuthModel requestModel;
  LoginsubmitEvent({
    required this.requestModel,
  });
    @override
  List<Object> get props => [requestModel];
}

class InitUserEvent extends LoginEvent {
  final String mssg;
  InitUserEvent({
    required this.mssg,
  });
}
class ErrorEvent extends LoginEvent{}




// import 'package:equatable/equatable.dart';
// import 'package:rest_api_conduit_app/models/loginmodel.dart';

// abstract class LoginEvent extends Equatable {}

// // ignore: must_be_immutable
// class LoginSubmitEvent extends LoginEvent {
//   LoginRequestModel authModel;
//   LoginSubmitEvent({required this.authModel});
//   @override
//   List<Object?> get props => [authModel];
// }

// // ignore: must_be_immutable
// class InitUserEvent extends LoginEvent {
//   String msg;

//   InitUserEvent({required this.msg});
//   @override
//   List<Object?> get props => [this.msg];
// }