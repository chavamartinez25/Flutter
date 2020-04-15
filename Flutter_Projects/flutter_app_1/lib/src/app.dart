import 'package:flutter/material.dart';
import 'package:flutter_app_1/src/Pages/contador_page.dart';
//import 'package:flutter_app_1/src/Pages/home_page.dart';


class MyApp extends StatelessWidget {

  @override
  build( context ) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Center(
        //child:  HomePage(),
        child: ContadorPage(),
      ),
    );
  }
}