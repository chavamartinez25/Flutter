import 'package:flutter/material.dart';

import 'package:guidecar_project/src/pages/home_page.dart';
import 'package:guidecar_project/src/pages/login/login_page.dart';
import 'package:guidecar_project/src/pages/login/signup_page.dart';


Map<String, WidgetBuilder> getAplicationRoutes() {

  return <String, WidgetBuilder> {

    'logIn'       :   ( BuildContext context ) => LogIn(),
    'signup'      :   ( BuildContext context ) => SignUp(),
    'home'        :   ( BuildContext context ) => HomePage(),

  };

}