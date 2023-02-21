import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/presentation/screens/profile_screen.dart';
import 'package:learn_bloc/service/api_repository.dart';
import '../../logic/bloc/user_bloc/user_bloc.dart';
import '../../model/UserModel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(
          RepositoryProvider.of<ApiRepository>(context)
      )..add(LoadUserEvent()),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if(state is UsersLoadingState){
            return  Scaffold(body: _buildLoading());
          }
          if(state is UsersLoadedState){
            List<User> userList = state.data.data!;
            return  Scaffold(appBar: AppBar(title: const Text("Users")), body: _buildListUser(userList),);
          }
          if(state is UsersErrorState){
            return  Scaffold( body: Center(child: Text(state.errorMessage),),);
          }
          return const Scaffold(body: Center(child: Text("oops")),);
        },
      ),
    );
  }

  Padding _buildListUser(List<User> userList) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => userCard(userList[index],context),
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: userList.length),
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());

  InkWell userCard(User user,BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileScreen(user: user),
            ));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 10)]),
        child: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  user.avatar ?? "",
                  height: 50,
                  width: 50,
                )),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${user.firstName} ${user.firstName}",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                Text("${user.email}"),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
