import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class HomePage extends StatelessWidget {

  final TextStyle tamanoTexto = new TextStyle(fontSize: 25.0);
  final conteo = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Titulo'),
        centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Número de clicks:', style: tamanoTexto),
              Text(conteo.toString(), style: tamanoTexto)
          ],)
        ),
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        floatingActionButton: FloatingActionButton(
          child: Icon( Icons.add ),
          onPressed: () {
            //this.conteo = conteo + 1;
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
  }

}