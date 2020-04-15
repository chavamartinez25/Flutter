import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:peliculas_project_3/src/models/actores_model.dart';
import 'package:peliculas_project_3/src/models/pelicula_model.dart';


class Peliculasprovider{

  String _apikey    = 'd4646149ae01602864895e936194e47e';
  String _url       = 'api.themoviedb.org';
  String _languaje  = 'en-US';

  int _popularesPage = 0;
  bool _cargando     = false;

  List<Pelicula> _populares = new List();
  // Esta es la declaracion del Stream, de tipo lista de peliculas, el .broadcast significa que podrá ser escuchado desde distintas partes del codigo
  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();
  // Esta funcion lo que hará será añadir al Stream la información, es por eso que recibirá una lista de peliculas.
  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;
  // Esta es la funcion que me permitirá sustraer la información del stream 
  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;
  // Esta función nos permitirá cerrar la conexión con el stream
  void disposeStream() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta( Uri url ) async {
    // Guardamos la respuesta de la peticion de http en la variable resp, para ello utilizamos el await para esperar a que resuelva la petición y regrese el resultado en la variable
    final resp = await http.get(url);
    // El proceso que se realiza aqui es recibir la respuesta como un mapa
    final decodedData = json.decode( resp.body );
    // Esta instrucción estará a cargo de recorrer todos los elementos del json y construir cada una de las peliculas 
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);
    // La condicion se cumple y retorna una lista de peliculas lista para ser usadas
    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {

    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key'  : _apikey,
      'language' : _languaje, 

    });

    return await _procesarRespuesta(url);

  }

  Future<List<Pelicula>> getPopulares() async {

    // Si está cargando datos, no hacemos nada, esperamos a que la peticion http en curso termine antes de hacer otra cosa
    if ( _cargando ) return[];

    _cargando = true;
    _popularesPage ++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key'  : _apikey,
      'language' : _languaje,
      'page'     : _popularesPage.toString()
    });

    final resp = await _procesarRespuesta(url);
    // Es decir enviará todas las peliculas, no solo las últimas peliculas
    _populares.addAll(resp);
    popularesSink( _populares );

    _cargando = false;

    return resp;

  }

  Future<List<Actor>>getCast( String peliculaID ) async {

    final url = Uri.https(_url, '3/movie/$peliculaID/credits',{
      'api_key'  : _apikey,
      'language' : _languaje,
    });

    // Mandamos a llamar al servicio, mediante el await ya que necesitamos esperar a que regrese la respuesta.
    final resp = await http.get(url);
    // Una vez recibida la respuesta decodificamos para obtener el mapa del json.
    final decodedData = json.decode( resp.body );
    // Ya que obtenemos el mapa, creamos una instancia de cast, y obtenemos cada uno de los actores
    final cast = new Cast.fromJsonList( decodedData['cast'] );
    // Por ultimo retornamos los actores que obtuvimos del trabajo con el mapa
    return cast.actores;

  }

  Future<List<Pelicula>> buscarPelicula( String query ) async {

    final url = Uri.https(_url, '3/search/movie', {
      'api_key'  : _apikey,
      'language' : _languaje, 
      'query'    : query
    });

    return await _procesarRespuesta(url);

  }


}