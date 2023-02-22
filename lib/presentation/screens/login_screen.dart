import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/presentation/screens/HomeScreen.dart';

import '../../logic/bloc/login_bloc/login_bloc.dart';
import '../../service/api_repository.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final LoginBloc _loginBloc = LoginBloc(ApiRepository());
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: BlocProvider(
        create: (context) => _loginBloc..add(LoginCheckEvent()),
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              showInSnackBar("Login Success",context,true);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
            }
            if (state is LoginFailedState) {
              showInSnackBar(state.error,context,state.status);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        'images/logo.png',
                        height: 100,
                        width: 100,
                      )),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter valid email id as abc@gmail.com'),
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter secure password'),
                  ),
                  const Text(
                    'Forgot Password',
                    style: TextStyle(color: Colors.blue, fontSize: 15),
                  ),

                  (state is LoginLoadingState)? Center(child: CircularProgressIndicator(),):ElevatedButton(
                    onPressed: () {
                      _loginBloc.add(LoginPressEvent(emailController.text.toString(), passwordController.text.toString()));
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 130,
                  ),
                  const Text('New User? Create Account')
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void showInSnackBar(String message, BuildContext context, bool status) {
    SnackBar snackBar = SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white)),
      backgroundColor: status ? Colors.green : Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
