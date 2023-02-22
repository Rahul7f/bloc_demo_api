import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../service/api_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiRepository _apiRepository;

  LoginBloc(this._apiRepository) : super(LoginInitial()) {

    on<LoginPressEvent>((event, emit) async {
      // TODO: implement event handler
      emit(LoginLoadingState());
      if (event.email.trim() == null || event.email.trim() == "") {
        emit(LoginFailedState("Enter Email address", false));
      } else if (event.password.trim() == null || event.password.trim() == "") {
        emit(LoginFailedState("Enter password", false));
      } else {
        Map<String, dynamic> data =
            await _apiRepository.loginUser(event.email, event.password);
        if (data["status"] == true) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('login', true);
          emit(LoginSuccessState());
        } else {
          emit(LoginFailedState("Login Failed", false));
        }
      }
    });

    on<LoginCheckEvent>((event, emit) async {
      // TODO: implement event handler
      final prefs = await SharedPreferences.getInstance();
      final bool? login = prefs.getBool('login');
      if(login!=null && login==true){
        emit(AlreadyLoginState());
      }else{
        emit(NotLoginState());
      }
    });

  }
}
