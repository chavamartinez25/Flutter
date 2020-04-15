import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:componentes_ejercicio_2/src/routes/routes.dart';
// import 'package:componentes_ejercicio_2/src/pages/home_temp.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Componentes App',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'), // Inglés
        const Locale('es'), // Español
      ],
      // home: HomePage(),
      // Se definen las rutas
      // El initialRoute, especifica cual es la ruta inicial por defecto
      initialRoute: '/',
      routes: getApplicationRoutes(),

      // Este es el metodo para las rutas dinámicas
      // onGenerateRoute: ( RouteSettings settings ) {
      //   return MaterialPageRoute(
      //     builder: ( BuildContext context ) => CardPage()
      //   );
      // },
    );
  }
}
