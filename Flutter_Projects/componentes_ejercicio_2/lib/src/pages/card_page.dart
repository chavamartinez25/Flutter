import 'package:flutter/material.dart';



class CardPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( 'Cards' ),
      ),
      body: ListView(
        // El padding nos permite darle margenes ya sea en una sola direccion o en todas.
        padding: EdgeInsets.all( 10.0 ),
        children: <Widget>[
          _cardTipo1(),
          SizedBox(height: 30.0),
          _cardTipo2(),
          SizedBox(height: 30.0),
          _cardTipo1(),
          SizedBox(height: 30.0),
          _cardTipo2(),
          SizedBox(height: 30.0),
          _cardTipo1(),
          SizedBox(height: 30.0),
          _cardTipo2(),
          SizedBox(height: 30.0),
          _cardTipo1(),
          SizedBox(height: 30.0),
          _cardTipo2(),
          SizedBox(height: 30.0),
          _cardTipo1(),
          SizedBox(height: 30.0),
          _cardTipo2(),
          SizedBox(height: 30.0),
        ],
      ),
    );
  }

  Widget _cardTipo1() {
    // Se retornará un areglo de tarjetas
    return Card(
      // Se especifica el Hijo, el cual colocará las tarjetas mediante columnas
      elevation: 10.0,
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular( 10.0 ) ),
      child: Column(
        // El hijp es un arrehlo de Widgets
        children: <Widget>[
          // Cada uno de los Widgets tiene un titulo
          ListTile(
            leading: Icon( Icons.photo_album, color: Colors.blue ),
            title: Text('Este es el titulo de la tarjeta'),
            subtitle: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: Text('Cancelar'),
                onPressed: (){},
              ),
              FlatButton(
                child: Text('Ok'),
                onPressed: (){},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _cardTipo2() {
    final card = Container(

      child: Column(
      children: <Widget>[

        FadeInImage(
          image: NetworkImage('https://www.rosatoursmexico.com/galeriart2/chichen-ruinas.jpg'),
          placeholder: AssetImage('assets/jar-loading.gif'),
          fadeInDuration: Duration( microseconds: 200 ),
          height: 300.0,
          fit: BoxFit.cover,
        ),
        // Image(
        //   image: NetworkImage('https://www.rosatoursmexico.com/galeriart2/chichen-ruinas.jpg'),
        // ),
        Container(
          padding: EdgeInsets.all( 10.0 ),
          child: Text('Pie de imagen')
        )
      ],
    ),
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: Offset( 2.0 , 10.0 ),
          )
        ]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: card,
      ),
    );
  }


}