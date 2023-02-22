import 'dart:convert';

import '../model/UserModel.dart';
import 'package:http/http.dart';

class ApiRepository {
  String getUserUrl = "https://reqres.in/api/users?page=2";
  String loginUrl = "https://reqres.in/api/login";

  Future<UserModel?> getUser() async {
    Response response = await get(Uri.parse(getUserUrl));
    if(response.statusCode==200){
      // return userModelFromJson(response.body);
      return userModelFromJson(response.body);
    }else{
      return null;
    }
  }
  Future<Map<String,dynamic>> loginUser(String email,String password) async {

    Map<String,String> body = {
      "email" : email,
      "password" : password,
    };
    try {
      Response response = await post(Uri.parse(loginUrl),body: body);
      print( jsonDecode(response.body).toString());
      if(response.statusCode==200 && jsonDecode(response.body)["error"]==null ){
        Map<String,dynamic> result = {
          "status" : true,
          "token" : jsonDecode(response.body)["token"],
        };
        return result;
      }else{
        Map<String,dynamic> result = {
          "status" : false,
          "error" : jsonDecode(response.body)["error"],
        };
        return result;
      }
    } on Exception catch (e) {
      // TODO
      Map<String,dynamic> result = {
        "status" : false,
        "token" : "Something wrong",
      };
      return result;
    }
  }
}