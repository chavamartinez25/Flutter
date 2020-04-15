import 'package:flutter/material.dart';
import 'package:peliculas_project_3/src/providers/peliculas_providers.dart';
import 'package:peliculas_project_3/src/models/pelicula_model.dart';


class DataSearch extends SearchDelegate {

  String seleccion = '';

  final peliculasProvider = new Peliculasprovider();

  final peliculas = [
    'Spider Man',
    'Acuaman',
    'Capitan America',
    'Shazam',
    'Iron Man'
  ];
  final peliculasRecientes = [
    'Spider Man',
    'Capintan America'
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro AppBar, cierre de busqueda, limpiar label, etc
    return [
      IconButton(
        icon: Icon( Icons.clear ),
        onPressed: (){
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Incono a la izquierda en el appbar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close( context, null );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blue,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

  
    if (query.isEmpty){
      return Container();
    }

    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        
        if( snapshot.hasData ){

          final peliculas = snapshot.data;

          return ListView(
            // Se convierte el listado de peliculas en un arreglo de pelicula
            children: peliculas.map( (pelicula){
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage( pelicula.getPosterImg()),
                  placeholder: AssetImage( 'asset/img/no-image.jpg' ),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text( pelicula.title ),
                subtitle: Text( pelicula.originalTitle ),
                onTap: (){
                  close(context, null);
                  pelicula.uniqueId = '';
                  Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                },
              );
            }).toList()
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }


      },
    );


  //   //Comentario de busqueda
  //   // Las sugerencias que aparecen cuando la persona escribe
  //   // La siguiente instruccion busca el query está bacío, entoces se mandarán las peliculas recientes
  //   // Le pasamos todo el listado de peliculas y debe de cumplir con la condicion de estar dentro del query
  //   // Por ultimo retornamos una lista
  //   final listaSugerida = ( query.isEmpty ) ? peliculasRecientes : peliculas.where( (p) => p.toLowerCase().startsWith(query.toLowerCase()) ).toList();

  //   return ListView.builder(
  //     itemCount: listaSugerida.length,
  //     itemBuilder: ( context, i ){
  //       return ListTile(
  //         leading: Icon( Icons.movie ),
  //         title: Text(listaSugerida[i]),
  //         onTap: (){
  //           seleccion = listaSugerida[i];
  //           showResults( context );
  //         },
  //       );
  //     },
  //   );
  }

} 