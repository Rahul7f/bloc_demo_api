import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_bloc/model/UserModel.dart';

class ProfileScreen extends StatelessWidget {
 User user;
   ProfileScreen({required this.user ,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("User Profile"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Container(
              height: 100,
              width: 100,
              decoration:  BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(user.avatar??""),
                  fit: BoxFit.cover
                )
              ),
            ),
            SizedBox(height: 20,),
            Text("${user.firstName} ${user.firstName}",style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 10,),
            Text("${user.email}"),
          ],
        ),
      ),
    );
  }
}
