import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

import 'package:form_validation_project7/src/models/producto_models.dart';


class ProductosProvider {

  final String _url = 'https://flutterprojects-fa351.firebaseio.com';


  Future<bool> crearProducto( ProductoModel producto ) async {

    final url = '$_url/productos.json';

    final resp = await http.post( url, body: productoModelToJson(producto) );

    final decodedData = json.decode(resp.body);

    print( decodedData );

    return true;

  }

  Future<bool> editarProducto( ProductoModel producto ) async {

    final url = '$_url/productos/${ producto.id }.json';

    final resp = await http.put( url, body: productoModelToJson(producto) );

    final decodedData = json.decode(resp.body);

    print( decodedData );

    return true;

  }



  Future<List<ProductoModel>> cargarPorductos() async {

    final url = '$_url/productos.json';
    final resp = await http.get(url);

    final Map<String, dynamic> decodeData = json.decode(resp.body);

    final List<ProductoModel> productos = new List();

    if ( decodeData == null ) return [];

    decodeData.forEach( ( id, prod ){
      final prodTemp = ProductoModel.fromJson(prod);
      prodTemp.id = id;

      productos.add( prodTemp );

    });

    print(productos);

    return productos;

  }

  Future<int> borrarProducto( String id ) async {

    final url = '$_url/productos/$id.json';
    final resp = await http.delete(url);

    print( json.decode(resp.body) );

    return 1;

  }

  Future<String> subirImagen( File imagen ) async {

    final url = Uri.parse('https://res.cloudinary.com/guidecar/image/upload/v1565039388/qeyvynmgkooszcetzx5h.png');
    final mimeType = mime( imagen.path ).split('/');

    final imageUploatRequest = http.MultipartRequest(
      'POST',
      url
    );

    final file = await http.MultipartFile.fromPath(
      'file',
      imagen.path,
      contentType: MediaType( mimeType[0], mimeType[1] )
    );

    imageUploatRequest.files.add(file);

    final streamResponse = await imageUploatRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if ( resp.statusCode != 200 && resp.statusCode != 201 ) {
      print('Algo salió mal');
      print(resp.body);
      return null;
    }

    final respData = json.decode(resp.body);
    print(respData);

    return respData['secure_url'];

  }

}