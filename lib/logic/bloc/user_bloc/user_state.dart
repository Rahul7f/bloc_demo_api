part of 'user_bloc.dart';

@immutable
abstract class UserState extends Equatable {}

// loading data state
class UsersLoadingState extends UserState {
  @override
  List<Object> get props => [];
}

// data loaded state
class UsersLoadedState extends UserState {
  final UserModel data;
  UsersLoadedState(this.data);
  @override
  List<Object> get props => [];
}


// data error state
class UsersErrorState extends UserState {
  String errorMessage;
  UsersErrorState(this.errorMessage);

  @override
  List<Object> get props => [];
}
