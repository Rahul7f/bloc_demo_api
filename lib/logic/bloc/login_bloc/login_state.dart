part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {

  @override
  List<Object> get props => [];
}

// login Success state
class LoginSuccessState extends LoginState {
  @override
  List<Object> get props => [];
}
// login failed state

class LoginFailedState extends LoginState {
  String error;
  bool status;
  LoginFailedState(this.error,this.status);
  @override
  List<Object> get props => [];
}
// login loading state
class LoginLoadingState extends LoginState {
  @override
  List<Object> get props => [];
}

// is already login
// class CheckLogin extends LoginState {
//   @override
//   List<Object> get props => [];
// }

class AlreadyLoginState extends LoginState {
  @override
  List<Object> get props => [];
}

class NotLoginState extends LoginState {
  @override
  List<Object> get props => [];
}

