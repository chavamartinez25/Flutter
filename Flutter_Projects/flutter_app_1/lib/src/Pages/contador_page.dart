import 'package:flutter/material.dart';

class ContadorPage extends StatefulWidget {

  @override
  createState() {
    return _ContadorPageState();
  }

}

class _ContadorPageState extends State<ContadorPage> {

  final _tamanoTexto = new TextStyle(fontSize: 25.0);
  int _conteo = 0;

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
              Text('Número de clicks:', style: _tamanoTexto),
              Text(_conteo.toString(), style: _tamanoTexto)
          ],)
        ),
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        floatingActionButton: _crearBotones()
        );
  }

  Widget _crearBotones() {

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SizedBox( width: 30 ),
        FloatingActionButton( child: Icon(Icons.exposure_zero), onPressed: _reset, ),
        Expanded(child: SizedBox()),
        FloatingActionButton( child: Icon(Icons.remove), onPressed: _sustraer, ),
        SizedBox( width: 5.0 ),
        FloatingActionButton( child: Icon(Icons.add), onPressed: _agregar , )
      ],
    );
  }

  void _agregar() {
    setState(() {
      _conteo++;
    });
  }

  void _sustraer() {
    setState(() {
      if( _conteo > 0 ) {
        _conteo--;
      }
    });
  }

  void _reset() {
    setState(() {
      _conteo = 0;
    });
  }

} 