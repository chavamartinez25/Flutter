import 'package:flutter/material.dart';
import 'package:preferencias_usuario_project6/src/pages/home_page.dart';
import 'package:preferencias_usuario_project6/src/pages/settings_page.dart';
import 'package:preferencias_usuario_project6/src/share_prefs/preferences.dart';
 
// Intruducimos a la funcion de arranque la creacion del InitPrefs para que la instancia sea creada antes de que se lanze la aplicacion y evitar que los valores queden en null
void main() async {

    final prefs = new PreferenciasUsuario();
    await prefs.initPrefs();

    runApp(MyApp());
  
  }
 
class MyApp extends StatelessWidget {

  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Preferencias',
      initialRoute: prefs.ultimaPagina,
      routes: {
        HomePage.routeName      :  ( BuildContext context ) => HomePage(),
        SettingsPage.routeName  :  ( BuildContext context ) => SettingsPage(),
      },
      theme: new ThemeData(
        primarySwatch: Colors.red
      ),
    );
  }
}