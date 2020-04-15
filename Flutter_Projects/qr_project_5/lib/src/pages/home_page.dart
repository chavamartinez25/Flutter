import 'dart:io';

import 'package:flutter/material.dart';

import 'package:qr_project_5/src/bloc/scans_bloc.dart';
import 'package:qr_project_5/src/models/scann_model.dart';

import 'package:qr_project_5/src/pages/direcciones_page.dart';
import 'package:qr_project_5/src/pages/mapas_page.dart';

import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:qr_project_5/src/utils/utils.dart' as utils;


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final scansBloc = new ScansBloc();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: scansBloc.borrarScanTodos,
          )
        ],
      ),
      body: _callPage( currentIndex ),
      bottomNavigationBar: _crearBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: () => _scannQR(context),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _crearBottomNavigationBar() {

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index){
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Mapas'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text('Direcciones'),
        ),
      ],
    );

  }

  Widget _callPage(int paginaActual) {

    switch( paginaActual ){

      case 0: return MapasPage();
      case 1: return DireccionesPage();

      default: 
        return MapasPage();

    }

  }

  _scannQR( BuildContext context ) async {

    // https://www.youtube.com/
    // geo:20.259005178263344,-98.63823309382326
    
    String futureString;

    try{
      futureString = await new QRCodeReader().scan();
    } catch(e){
      futureString = e.toString();
    }

    // print('futureString: $futureString');

    if (futureString != null){
      // Creamos una instancia de ScanModel mandandole la información en este caso de la pagina web
      final scan = ScanModel( valor: futureString );
      // En este caso mandamos a llamar al scan y no a la base de datos directamente
      scansBloc.agregarScan(scan);

      // Esta instruccion sirve para demorar la apertura del sitio web, ya que la cámara tarda al rededor de 750 milisegundos en cerrarse.
      if ( Platform.isIOS ) {
        Future.delayed(Duration(microseconds: 750), (){
          utils.abrirScan(context,scan);
        });
      } else {
        utils.abrirScan(context,scan);
      }
      
    }

  }

}