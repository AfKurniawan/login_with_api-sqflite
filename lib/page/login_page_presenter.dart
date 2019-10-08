import 'package:flutter_login_apps/data/rest_data_source.dart';
import 'package:flutter_login_apps/model/user.dart';

abstract class LoginPageContract {
  void onLiginSuccess(User user);
  void onLoginError(String errorTxt);

}

class LoginPagePresenter{
  LoginPageContract _view;
  RestDataSource api = new RestDataSource();

  LoginPagePresenter(this._view);

  loginAction(String username, String password){
    api.login(username, password).then((User user){
      _view.onLiginSuccess(user);
    }).catchError((Exception error) => _view.onLoginError(error.toString()));
  }
}