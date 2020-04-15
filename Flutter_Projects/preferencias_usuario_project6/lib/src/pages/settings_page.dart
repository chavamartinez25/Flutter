import 'package:flutter/material.dart';
import 'package:preferencias_usuario_project6/src/share_prefs/preferences.dart';
import 'package:preferencias_usuario_project6/src/widgets/menu_widget.dart';


class SettingsPage extends StatefulWidget {

  static final String routeName = 'settings';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  bool _colorSecundario;
  int _genero;
  String _nombre;

  // El código a continuación sirve para guardar el estado el Text Field en la app.
  TextEditingController _textController;

  final prefs = new PreferenciasUsuario();

  @override


  void initState() {
    super.initState();

    prefs.ultimaPagina = SettingsPage.routeName;
    _genero            = prefs.genero;
    _colorSecundario   = prefs.colorSecundario;
    _nombre            = prefs.nombre;
    // cargarPrefs();
    _textController    = new TextEditingController( text: prefs.nombre );
  }

  // cargarPrefs() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   _genero = prefs.getInt('genero');
  //   setState(() {});
  // }

  // Esta funcion nos permite guardar las preferencias del usuario en el dispositivo
  _setSelectedRadio( int valor ) { //async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setInt('genero', valor );
    prefs.genero = valor;
    setState(() {
      _genero = valor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes'),
        backgroundColor: ( prefs.colorSecundario ) ? Colors.teal : Colors.blue,
      ),
      drawer: MenuWidget(),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5.0),
            child: Text('Settings', style: TextStyle(fontSize: 45.0,fontWeight: FontWeight.bold),),
          ),
          Divider(),
          SwitchListTile(
            value: _colorSecundario,
            title: Text('Color secundario'),
            onChanged: ( value ){
              setState(() {
                _colorSecundario = value;
                prefs.colorSecundario = value;
              });
            },
          ),
          RadioListTile(
            value: 1,
            title: Text('Masculino'),
            groupValue: _genero,
            onChanged: _setSelectedRadio,
          ),
          RadioListTile(
            value: 2,
            title: Text('Femenino'),
            groupValue: _genero,
            onChanged: _setSelectedRadio,
          ),
          Divider(),
          Container(
            padding: EdgeInsets.symmetric( horizontal: 20.0 ),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                helperText: 'Nombre de la persona usando el teléfono' 
              ),
              onChanged: ( value ){
                prefs.nombre = value;
              },
            ),
          )
        ],
      )
    );
    
  }
}