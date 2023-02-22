import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../model/UserModel.dart';
import '../../../service/api_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final ApiRepository _apiRepository;
  UserBloc(this._apiRepository) : super(UsersLoadingState()) {
    on<LoadUserEvent>((event, emit) async {
      emit(UsersLoadingState());
     try{
       UserModel? users = await _apiRepository.getUser();
       if(users != null && users.data!=null && users.data!.isNotEmpty){
         emit(UsersLoadedState(users!));
       }else{
         emit(UsersErrorState("Data is NULL"));
       }
     }catch(e){
       emit(UsersErrorState("Api not Working ${e.toString()}"));

     }
    });
  }
}
