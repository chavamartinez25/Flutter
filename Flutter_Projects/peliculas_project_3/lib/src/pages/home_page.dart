import 'package:flutter/material.dart';
import 'package:peliculas_project_3/src/providers/peliculas_providers.dart';
import 'package:peliculas_project_3/src/search/search_delegate.dart';
import 'package:peliculas_project_3/src/widgets/card_swiper_widget.dart';
import 'package:peliculas_project_3/src/widgets/movie_horizontal.dart';


class HomePage extends StatelessWidget {

  final peliculasProvider = new Peliculasprovider();

  @override
  Widget build(BuildContext context) {
    // Una vez que aparece la pantalla mandamos a llamar al metodo getPopulares para que retorne la lista de peliculas
    peliculasProvider.getPopulares();

    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas en cines'),
        centerTitle: false,
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              showSearch( 
                context: context, 
                delegate: DataSearch(),
                //query: 'Search'
              );
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swipeTarjetas(),
            _footer( context )
          ],
        ),
      )
    );
  }

  Widget _swipeTarjetas(){
    // Es el future que regresaremos con las peliculas
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        // Si el snapshot tiene información se envia la misma, de otra forma en la primera iteración posiblemente el valor de snapshot sea null, por lo tanto en ese caso se retornará
        // un loading para evitar problemas
        if ( snapshot.hasData ) {
          return CardSwiper( peliculas: snapshot.data );
        } else {
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        }
      },
    );
  }

  Widget _footer( BuildContext context ){

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('Populares', style: Theme.of( context ).textTheme.subhead)
          ),
          SizedBox(height: 5.0),
          
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if ( snapshot.hasData ) {
                return MovieHorizontal(
                  peliculas: snapshot.data,
                  siguientePagina: peliculasProvider.getPopulares,
                );
              } else {
                return Center(child: CircularProgressIndicator());
              } 
            }
          ),

        ],
      )
    );

  }


} 