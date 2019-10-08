import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_login_apps/auth.dart';
import 'package:flutter_login_apps/data/database_helper.dart';
import 'package:flutter_login_apps/data/rest_data_source.dart';
import 'package:flutter_login_apps/model/user.dart';
import 'package:flutter_login_apps/page/login_page_presenter.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> implements LoginPageContract, AuthStateListener {
  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _username, _password;
  LoginPagePresenter _presenter;

  LoginPageState() {
    _presenter = new LoginPagePresenter(this);
    var authStateProvider = new AuthStateProvider();
    authStateProvider.subscribe(this);
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _presenter.loginAction(_username, _password);
      });
    }
  }

  void _showSnackbar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

  @override
  void onAuthStateChanged(AuthState state) {
    // TODO: implement onAuthStateChanged
    if (state == AuthState.LOGGED_IN)
      Navigator.of(_ctx).pushReplacementNamed("/home");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _ctx = context;
    var loginButton = new RaisedButton(
      onPressed: _submit,
      child: new Text("LOGIN"),
      color: Colors.primaries[0],
    );

    var loginForm = new Column(
      children: <Widget>[
        new Text("Login App", textScaleFactor: 2.0),
        new Form(
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextFormField(
                  onSaved: (val) => _username = val,
                  validator: (val) {
                    return val.length < 10
                        ? "Username at list minimum 10 character"
                        : null;
                  },
                  decoration: new InputDecoration(labelText: "Username"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextFormField(
                  onSaved: (val) => _password = val,
                  decoration: InputDecoration(labelText: "Password"),
                ),
              )
            ],
          ),
        ),
        _isLoading ? new CircularProgressIndicator() : loginButton
      ],
      crossAxisAlignment: CrossAxisAlignment.center,
    );

    return new Scaffold(
      appBar: null,
      key: scaffoldKey,
      body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
              image: new AssetImage("assets/login_background.jpg"),
              fit: BoxFit.cover),
        ),
        child: new Center(
          child: new ClipRRect(
            child: new BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: new Container(
                child: loginForm,
                height: 300,
                width: 300,
                decoration: new BoxDecoration(
                  color: Colors.grey.shade50.withOpacity(0.5)
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void onLoginError(String ErrorTxt){
    _showSnackbar(ErrorTxt);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLiginSuccess(User user) async{
    _showSnackbar(user.toString());
    setState(() {
      _isLoading = false;
    });

    var db = new DatabaseHelper();
    await db.saveUser(user);
    var authStateProvider = new AuthStateProvider();
    authStateProvider.notify(AuthState.LOGGED_IN);
  }



}
