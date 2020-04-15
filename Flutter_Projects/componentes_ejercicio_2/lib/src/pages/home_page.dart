import 'package:componentes_ejercicio_2/src/pages/alert_page.dart';
import 'package:flutter/material.dart';
import 'package:componentes_ejercicio_2/src/providers/menu_provider.dart';
import 'package:componentes_ejercicio_2/src/utils/icono_string_util.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( 'Componentes' )
      ),
      body: _lista(),
    );
  }

  // La carga de datos de realiza mediante un Future, porque la contrucción de la app, finaliza antes de que se retorne la info
  // del json, es por eso que se debe de dejar a cargo de una tarea asincrona

  Widget _lista() {

    // menuProvider.cargarData()
    return FutureBuilder(
      future: menuProvider.cargarData(),
      initialData: [],
      builder: ( context, AsyncSnapshot<List<dynamic>> snapshot ){

        return ListView(
          children: _listaItems( snapshot.data, context )
         );
      },
    );

    
  }

// Esta funcion recibirá una lista de dinamica y retornará una lista de Widgets
// <dynamic> data: es el json que tenemos pre-cargado en la app.
// La funcion de getIcon nos permite tomar un texto y tomarlo como propiedad para mostrarlo como Icono
  List<Widget> _listaItems( List<dynamic> data, BuildContext context ) {
    
    final List<Widget> opciones = []; 

    data.forEach((opt) {
      final widgetTitle = ListTile(
        title: Text( opt['texto'] ),
        leading: getIcon( opt['icon'] ),
        trailing: Icon( Icons.arrow_forward_ios, color: Colors.blue  ), 
        onTap: (){

          Navigator.pushNamed( context, opt[ 'ruta' ] );


          // Opcion de navegacion cuando es sencilla
          // El Context del push es la informacion global para saber cual es la que sigue y cual es a la que regresaré
          // final route = MaterialPageRoute(
          //     builder: ( context ) => AlertPage()
          //   );
          // Navigator.push(context, route);
        },
      );
      opciones..add( widgetTitle )
              ..add( Divider() );
    });
    return opciones;
  }
}