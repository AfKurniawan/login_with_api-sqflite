

import 'package:flutter/material.dart';
import 'package:flutter_login_apps/page/home_page.dart';
import 'package:flutter_login_apps/page/login_page.dart';

final routes =  {

  '/login'  : (BuildContext context) => new LoginPage(),
  '/home'   : (BuildContext context) => new HomePage(),
  '/'       : (BuildContext context) => new LoginPage(),


};