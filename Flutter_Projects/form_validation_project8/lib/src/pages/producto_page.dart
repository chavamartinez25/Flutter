import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:form_validation_project7/src/models/producto_models.dart';
import 'package:form_validation_project7/src/providers/productos_provider.dart';
import 'package:form_validation_project7/src/utils/utils.dart' as utils;



class ProductoPage extends StatefulWidget {

  // Esta será un Key para identificar un Form, por eso es de tipo FormState
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {

  final formKey = GlobalKey<FormState>();
  final productoProvider = new ProductosProvider();
  // Identificador único del Scaffold
  final scaffoldKey = GlobalKey<ScaffoldState>();

  ProductoModel producto = ProductoModel();
  bool _guardando = false;
  File photo;

  @override
  Widget build(BuildContext context) {

    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;

    if ( prodData != null ) {
      producto = prodData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _seleccionarPhoto,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _tomarPhoto,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _mostrarPhoto(),
                _crearNombre(),
                _crearPrecio(),
                _crearDisponible(),
                _crearBoton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Nombre',
      ),
      onSaved: (value) => producto.titulo = value,
      validator: ( value ){
        if ( value.length < 3 ){
          return 'Ingrese el nombre del producto';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: producto.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Producto'
      ),
      onSaved: (value) => producto.valor = double.parse(value),
      validator: ( value ){

        if ( utils.isNumeric(value) ) {
          return null;
        } else {
          return 'Solo números';
        }

      },
    );
  }

  Widget _crearDisponible() {

    return SwitchListTile(
      value: producto.disponible,
      title: Text('Disponible'),
      activeColor: Colors.deepPurple,
      onChanged: (value) => setState((){
        producto.disponible = value;
      }),
    );

  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      color: Colors.deepPurple,
      label: Text('Guardar', style: TextStyle(color: Colors.white)),
      icon: Icon(Icons.save, color: Colors.white,),
      onPressed: ( _guardando ) ? null : _submit,
    );
  }

  void _submit() async {

    if ( !formKey.currentState.validate() ) return;

    // Esto me permitirá guardar todos los estados de los text inputs que tengo activos
    formKey.currentState.save();
    //
    setState(() {
      _guardando = true;
    });

    if ( photo != null ) {
      producto.fotoUrl = await productoProvider.subirImagen(photo);
    }

    if ( producto.id == null ) {
      productoProvider.crearProducto(producto);
    } else {
      productoProvider.editarProducto(producto);
    }

    // setState(() {
    //   _guardando = false;
    // });
    mostrarSnackbar('Registro Guardado');

    Navigator.pop(context);

  }

  void mostrarSnackbar( String mensaje ) {

    final snackBar= SnackBar(
      content: Text( mensaje ),
      duration: Duration( milliseconds: 1500 ),
    );

    scaffoldKey.currentState.showSnackBar(snackBar);

  }

  _mostrarPhoto() {

    if ( producto.fotoUrl != null ) {
      // Todo tengo que hacer esto
      return Container();
    } else {
      return Image(
        // Si la fotografía tiene valor, entonces toma el path, de otra forma, tomará la imagen de la carpeta de assets
        image: AssetImage( photo?.path ?? 'assets/no-image.png'),
        height: 300.0,
        fit: BoxFit.cover
      );
    }

  }

  _seleccionarPhoto() async {

    _procesarImagen( ImageSource.gallery );

  }

  _tomarPhoto() async {

    _procesarImagen( ImageSource.camera );

  }

  _procesarImagen( ImageSource origen ) async {

    photo = await ImagePicker.pickImage(
      source: origen
    );

    if ( photo != null ) {
      // Limpieza
    }

    setState(() {
    });

  }

}