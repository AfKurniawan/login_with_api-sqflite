


import 'package:flutter/material.dart';
import 'package:flutter_login_apps/routes.dart';

void main() => runApp(new MyApps());


class MyApps extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: 'Login Api With Database Sqflite',
      theme: new ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      routes: routes,
    );
  }
}