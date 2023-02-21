import '../model/UserModel.dart';
import 'package:http/http.dart';

class ApiRepository {
  String endUrl = "https://reqres.in/api/users?page=2";

  Future<UserModel?> getUser() async {
    Response response = await get(Uri.parse(endUrl));
    if(response.statusCode==200){
      // return userModelFromJson(response.body);
      return userModelFromJson(response.body);
    }else{
      return null;
    }
  }
}