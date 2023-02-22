part of 'login_bloc.dart';
@immutable
abstract class LoginEvent extends Equatable {}

 class LoginPressEvent extends LoginEvent {
   String email;
   String password;
   LoginPressEvent(this.email, this.password);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}


class LoginCheckEvent extends LoginEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}


