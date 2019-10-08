
import 'package:flutter_login_apps/model/user.dart';
import 'package:flutter_login_apps/utils/constants.dart';
import 'package:flutter_login_apps/utils/network_util.dart';

class RestDataSource {
  NetworkUtil _networkUtil = new NetworkUtil();


  Future<User> login (String username, String password){
    return _networkUtil.post(Constants.LOGIN_URL, body: {
      "username"  : username,
      "password"  : password
    }).then((dynamic res){
      print(res.toString());
      if(res["error"]) throw new Exception(res["error_msg"]);
      return new User.map(res["user"]);
    });
  }

}