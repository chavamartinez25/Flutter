import 'dart:async';

import 'package:qr_project_5/src/bloc/validator.dart';
import 'package:qr_project_5/src/providers/db_provider.dart';

class ScansBloc with Validators {

  static final ScansBloc _singleton = new ScansBloc._internal();

  // En caso de que no exista
  factory ScansBloc(){
    return _singleton;
  }

  ScansBloc._internal() {
    // Obtener Scans de la base de datos
    obtenerScans();
  }

  // Esta instrucción nos permite crear un Stream a partir de una lista de objetos del ScanModel para que la misma sea escuchada en distintos compoenentes de la app
  final _scansController  = StreamController<List<ScanModel>>.broadcast();

  // Este Stream estará escuchando a los puntos de geolocation 
  Stream<List<ScanModel>> get scansStream     => _scansController.stream.transform(validarGeo);
  // Este Stream escuchará las peticiones de HTTP
  Stream<List<ScanModel>> get scansStreamHttp => _scansController.stream.transform(validarHttp);

  // Esta funcion cierra el Stream, pero antes pregunta si este stream existe ?
  dispose(){
    _scansController?.close();
  }

  // Se obtienen todos los scans, en este caso el método getTodosScans retorna un Future pero con el await esperamos la lista de scans
  obtenerScans() async {
    _scansController.sink.add( await DBProvider.db.getTodosScans() );
  }

  agregarScan( ScanModel scan ) async {
    await DBProvider.db.nuevoScan(scan);
    obtenerScans();
  }

  // Esta instrucción nos permite hacer el borrado del scan depemndiendo del id que se tenga y posteriormente agrega todos los scans que existen en ese momento
  borrarScan( int id ) async {
    await DBProvider.db.deleteScan(id);
    obtenerScans();
  }

  borrarScanTodos() async {
    await DBProvider.db.deleteAll();
    obtenerScans();
  }

}