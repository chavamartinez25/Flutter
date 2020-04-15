import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guidecar_project/src/routes/routes.dart';


void main() => runApp(GuideCar());

class GuideCar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent
    ));

    return MaterialApp(
      title: 'GuidecarApp',
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: getAplicationRoutes(),
    );
  }
}