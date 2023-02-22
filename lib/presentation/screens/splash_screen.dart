import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/presentation/screens/login_screen.dart';

import '../../logic/bloc/login_bloc/login_bloc.dart';
import '../../service/api_repository.dart';
import 'HomeScreen.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
  final LoginBloc _loginBloc = LoginBloc(ApiRepository());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _loginBloc..add(LoginCheckEvent()),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is AlreadyLoginState) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
            }
            if (state is NotLoginState) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
            }
          },
          child: Center(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset("images/logo.png", height: 100, width: 100)),
          ),
        ),
      ),
    );
  }
}
