import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/presentation/screens/HomeScreen.dart';
import 'package:bloc/bloc.dart';
import 'package:learn_bloc/presentation/screens/login_screen.dart';
import 'package:learn_bloc/service/api_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      // home: RepositoryProvider(create: (context) => ApiRepository(), child:  const HomeScreen()),
      home: LoginScreen(),
    );
  }
}
