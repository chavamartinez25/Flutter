import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;

class SliderPage extends StatefulWidget {

  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {

  double _valorSlider = 100.0;
  bool _bloquearCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text('Sliders'),
       ),
       body: Container(
         padding: EdgeInsets.only(top: 50.0),
         child: Column(
            children: <Widget>[
              _crearSlider(),
              _checkBox(),
              _crearSwitch(),
              Expanded(
                child: _crearImagen()
              ),
            ],
           )
       )
    );
  }

  Widget _crearSlider(){
    
    return Slider(
      activeColor: Colors.indigoAccent,
      label: 'Tamaño de la imagen',
      //divisions: 10,
      value: _valorSlider,
      min: 10.0,
      max: 400.0,
      // Esta es la condicion, si el _bloquearCheck es falso retorna un null, en caso contrario retornará el codigo que permite interactuar con el slider
      onChanged: ( _bloquearCheck ) ? null : ( valor ){
        setState(() {
          _valorSlider = valor;
        });
      },
    );
  }

  Widget _checkBox() {
    // return Checkbox(
    //   value: _bloquearCheck,
    //   onChanged: (valor){
    //     setState(() {
    //       _bloquearCheck = valor;
    //     });
    //   },
    // );
    return CheckboxListTile(
      title: Text('Bloquear slider'),
      value: _bloquearCheck,
      onChanged: (valor){
        setState(() {
          _bloquearCheck = valor;
        });
      },
    );
  }

  Widget _crearSwitch() {
    return SwitchListTile(
      title: Text('Bloquear slider'),
      value: _bloquearCheck,
      onChanged: (valor){
        setState(() {
          _bloquearCheck = valor;
        });
      },
    );
  }

  Widget _crearImagen() {

    return Image(
      image: NetworkImage('http://pluspng.com/img-png/gray-wolf-png-hd-wolf-png-1024.png'),
      width: _valorSlider,
      fit: BoxFit.contain,
    );

  }

}