
import 'package:flutter/material.dart';
import 'dart:ui' as prefix0;
import 'dart:math';


class BotonesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _fondoApp(),

          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _titulos(),
                _botonesRedondeados(),
              ],
            ),
          )

        ],
      ),
      
      bottomNavigationBar: _bottonNavigationBar(context)

    );
  }

  Widget _fondoApp() {

    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset(0.0,0.6),
          end: FractionalOffset(0.0,1.0),
          colors: [
            Color.fromRGBO(52, 54, 101, 1.0),
            Color.fromRGBO(35, 37, 57, 1.0)
          ]
        )
      ),
    );

    final cajaRosa = Transform.rotate(
      angle: -pi / 5.0,
      child: Container(
        height: 360.0,
        width: 360.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80.0),
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(236, 98, 188, 1.0),
              Color.fromRGBO(241, 142, 172, 1.0)
            ]
          )
        ),
      ),
    );
    
    

    return Stack(
      children: <Widget>[
        gradiente,
        Positioned(
          top: -100.0,
          child: cajaRosa,
        )
        
      ],
    );
  }

  Widget _titulos() {

    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Classify transaction',style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.0),
            Text('Classify this transaction into a particular category', style: TextStyle(color: Colors.white, fontSize: 18.0))
          ],
        ),
      ),
    );

  }

  Widget _bottonNavigationBar( BuildContext context ) {
    // Para cambiar las propiedades del botton navigation Bar es necesaria la creacion de un nuevo tema y aplicarlo a un elemento en particular,
    // En este caso el menu que intentamos modificar con un estilo personalizado.
    return Theme(
      data: Theme.of(context).copyWith(
        // Este es el color principal de fondo del tema 
        canvasColor: Color.fromRGBO(55, 57, 84, 1.0),
        primaryColor: Colors.pinkAccent,
        // Se cambia el color del texto de la aplicacion y por consiguiente el color de los iconos
        textTheme: Theme.of(context).textTheme.copyWith(caption: TextStyle(color: Color.fromRGBO(116, 117, 152, 1.0)))
      ),
      child: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, size: 30.0,),
            title: Container()
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bubble_chart, size: 30.0,),
            title: Container()
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle, size: 30.0,),
            title: Container()
          ),
        ],
      ),
    );

  }

  Widget _botonesRedondeados() {
    return Table(
      children: [
        TableRow(
          children: [
            _crearBotonRedondeado( Colors.blue, Icons.tag_faces, 'General' ),
            _crearBotonRedondeado( Colors.purple, Icons.directions_bus, 'Transports' ),
          ]
        ),
        TableRow(
          children: [
            _crearBotonRedondeado( Colors.pink, Icons.shopping_basket, 'Shopping' ),
            _crearBotonRedondeado( Colors.blueAccent, Icons.movie, 'Entretaiment' ),
          ]
        ),
        TableRow(
          children: [
            _crearBotonRedondeado( Colors.orange, Icons.location_on, 'Location' ),
            _crearBotonRedondeado( Colors.green, Icons.fastfood, 'Food' ),
          ]
        ),
        TableRow(
          children: [
            _crearBotonRedondeado( Colors.redAccent, Icons.favorite, 'My favorite' ),
            _crearBotonRedondeado( Colors.yellow, Icons.fitness_center, 'Fitnes' ),
          ]
        )
      ],
    );
  }

  Widget _crearBotonRedondeado( Color color, IconData icon, String texto ) {




    return BackdropFilter(
      filter: prefix0.ImageFilter.blur( sigmaX: 0, sigmaY: 0),
      child: Container(
        height: 180.0,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Color.fromRGBO(62, 66, 107, 0.7),
          borderRadius: BorderRadius.circular(20.0)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(height: 5.0),
            CircleAvatar(
              backgroundColor: color,
              radius: 35.0,
              child: Icon(icon, color: Colors.white, size: 30.0),
            ),
            Text(texto, style: TextStyle(color: color)),
            SizedBox(height: 5.0)
          ],
        ),
      ),
    );
  }

}


// Codigo del Botton Navigation Bar genérico:
// BottomNavigationBar(
//   fixedColor: Colors.pink,
//   items: <BottomNavigationBarItem>[
//     BottomNavigationBarItem(
//       title: Container(),
//       icon: Icon(Icons.calendar_today)
//     ),
//     BottomNavigationBarItem(
//       title: Container(),
//       icon: Icon(Icons.pie_chart_outlined)
//     ),
//     BottomNavigationBarItem(
//       title: Container(),
//       icon: Icon(Icons.supervised_user_circle)
//     ),
//   ],
// ),