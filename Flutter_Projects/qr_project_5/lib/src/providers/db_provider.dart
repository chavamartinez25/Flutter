import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_project_5/src/models/scann_model.dart';
export 'package:qr_project_5/src/models/scann_model.dart';


class DBProvider {
  // Esta es mi intancia de la base de datos
  static Database _database;
  // Esta es una instancia de mi clase
  static final DBProvider db = DBProvider._();
  // Este es el constructor privado
  DBProvider._();
  // Es una funcion que retorna un Future de tipo Database
  Future<Database> get database async {
    // Si existe datos se regresan esos datos
    if ( _database != null ) return _database;
    // En caso que no existan datos, los datos serán extraidos de la funcion initDB() mediente una funcion asincrona
    _database = await initDB();
    return _database;
  }

  initDB() async {
    // En que parte de nuestro dispositivo se encuentra la BD
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // Este es el path completo de donde se encuentra mi base de datos, incluyendo el nombre del archivo
    final path = join( documentsDirectory.path, 'ScansDB.db' );
    // Esta son las caracteristicas de la base de datos, hay que actualizar la version en cambios significativos
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){},
      // Esta es la instruccion de qué hará una vez que esté creada la base de datos
      onCreate: ( Database db, int version ) async {
        // Creacion de nuestra primera tabla
        await db.execute(
          'CREATE TABLE Scans ('
          ' id INTEGER PRIMARY KEY,'
          ' tipo TEXT,'
          ' valor TEXT'
          ')'
        );
      },
    );
  }

  // CREAR registros de DB - Método 1
  nuevoScanRaw( ScanModel nuevoScan ) async {
    // Se espera a que obtenga la base de datos para grabar o ser usada
    final db = await database;
    // Esta es la instruccion para insertar los datos a la DB (Nota: Son importantes los espacios en la sentencia SQL)
    final res = await db.rawInsert(
      "INSERT Into Scans (id, tipo, valor) "
      "VALUES ( ${ nuevoScan.id }, '${ nuevoScan.tipo }', '${ nuevoScan.valor }' )"
    );
    return res;
  }

  // CREAR registros de DB - Método 2
  nuevoScan( ScanModel nuevoScan ) async {
    // Se espera a que obtenga la base de datos para grabar o ser usada
    final db = await database;
    // La funcion toJson está definida en el modelo de datos de la DB, por lo tanto regresará un mapa con los elementos id, tipo y valor con sus respectivos valores a insertar
    final res = await db.insert('Scans', nuevoScan.toJson());
    return res;
  }

  // SELECT - Obtener información
  Future<ScanModel> getScanId( int id ) async {
    // Se espera a que obtenga la base de datos para grabar o ser usada
    final db = await database;
    // Es es la sentencia que nos permitirá obtener los datos de la base de datos, donde el id sea del valor que tengamos en whereArgs retornará una lista de mapas
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);
    // Regresa una instancia de scan model del mapa obtenido del query, si no regresa nada, retornara un null
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  // SELECT - Obtener información de todos los scans
  Future<List<ScanModel>> getTodosScans() async {
    // Se espera a que obtenga la base de datos para grabar o ser usada
    final db = await database;
    final res = await db.query('Scans');
    // Si la respuesta no está vacía, pasará cada uno de los elementos a un mapa de tipo ScanModel y lo hará una lista en caso contrario retornará una lista vacía.
    List<ScanModel> list = res.isNotEmpty 
                              ? res.map( (scan) => ScanModel.fromJson(scan) ).toList()
                              : [];
    return list;
  }

  // SELECT - Obtener información de los scans según su tipo ('http' o 'geo')
  Future<List<ScanModel>> getScansTipo( String tipo ) async {
    // Se espera a que obtenga la base de datos para grabar o ser usada
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Scans WHERE tipo ='$tipo'");
    // Si la respuesta no está vacía, pasará cada uno de los elementos a un mapa de tipo ScanModel y lo hará una lista en caso contrario retornará una lista vacía.
    List<ScanModel> list = res.isNotEmpty 
                              ? res.map( (scan) => ScanModel.fromJson(scan) ).toList()
                              : [];
    return list;
  }

  // UPDATE - Actualizacion de registros
  // Esta funcion retorna un 0 si no se actualizaron los datos y un 1 si se actualizaron
  Future<int> updateScan( ScanModel nuevoScan ) async {
    // Se espera a que obtenga la base de datos para grabar o ser usada
    final db = await database;
    // Esta es la instruccion para actualizar los datos de la tabla dada, donde el id del elemento sea igual al id dado
    final res = await db.update('Scans', nuevoScan.toJson(), where: 'id = ?', whereArgs: [nuevoScan.id]);
    return res;
  }

  // Delete - Eliminacion de registros de un elemento en particular
  // La funcion regresará como respuesta un 1 si se borró el elemento y un 0 si no se borró
  Future<int> deleteScan( int id ) async {
    // Se espera a que obtenga la base de datos para grabar o ser usada
    final db = await database;
    // En esta instrucción se define de que tabla queremos hacer el borrado y el id del elemento a borrar
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  // Delete - Eliminacion de registros de toda una tabla
  // La funcion regresará como respuesta un 1 si se borró el elemento y un 0 si no se borró
  Future<int> deleteAll() async {
    // Se espera a que obtenga la base de datos para grabar o ser usada
    final db = await database;
    // En esta instrucción se define la tabla que queremos borrar
    final res = await db.rawDelete('DELETE FROM Scans');
    return res;
  }


}