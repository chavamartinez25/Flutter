import 'package:flutter/material.dart';
import 'package:peliculas_project_3/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {

  final List<Pelicula> peliculas;
  //Esta propiedad será la que permitirá acrgar más peliculas en la lista Scroll Horizontal
  final Function siguientePagina;

  MovieHorizontal({ @required this.peliculas, @required this.siguientePagina });

  final _pageController = new PageController(
    initialPage: 1,
    // Es decir quiero mostrar tres tarjetas en la visualización
    viewportFraction: 0.3
  );

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;
    // Este es el listener que nos ayudará a detectar cuando el usuario llego al final de la lista de peliculas
    _pageController.addListener( (){
      // Si los pixeles del _pageController son mayores o igual a los pixeles máximo de si mismo menos 200 hará lo siguiente
      if ( _pageController.position.pixels >= _pageController.position.maxScrollExtent - 200 ){
        siguientePagina();
      }

    });

    // El pageview renderiza los elementos de manera simultanea, es decir si tenemos 1,000 peliculas en la primer llamada las renderizará de forma simultanea, y puede deribar en porblemas de memoria
    // El pageView.builder renderiza elementos bajo demanda, solo aquellos que son necesarios.
    return Container(
      height: _screenSize.height * 0.22,
      child: PageView.builder(
        // El pageSnapping se refiere a que no queremos que pare el carrusel de imagenes
        pageSnapping: false,
        controller: _pageController,
        // children: _tarjetas( context ),
        // Este elemento me permite hacer dinámico la carga de datos
        itemCount: peliculas.length,
        // Este itemBuilder, se ejecutará para cada pelicula que necesitemos mostrar en el scroll horizontal
        itemBuilder: ( context, i ){
          return _tarjeta(context, peliculas[i]);
        },
      ),
    );
  }



  Widget _tarjeta( BuildContext context, Pelicula pelicula ) {

    pelicula.uniqueId = '${ pelicula.id }-poster';

    final peliculaTarjeta =  Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            Hero(
              tag: pelicula.uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  image: NetworkImage( pelicula.getPosterImg() ),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                  height: 140.0,
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          ]
        )
      );
      // Este metodo nos permitirá detectar cuando el usuario toque alguna tarjeta
      return GestureDetector(
        child: peliculaTarjeta,
        onTap: (){ 
          // Esta es lla instrucción para navegar entre pantallas, en el campo de arguments, enviaremos toda la pelicula
          Navigator.pushNamed(context, 'detalle', arguments: pelicula);
          //print(pelicula.title);
        },
      );
  }


  List<Widget> _tarjetas( context ) {

    return peliculas.map( (pelicula) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage( pelicula.getPosterImg() ),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 140.0,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          ]
        )
      );

    }).toList();

  }

}