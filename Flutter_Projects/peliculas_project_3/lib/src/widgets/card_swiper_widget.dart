import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas_project_3/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {

  final List<Pelicula> peliculas;

  // Este es el constructor del widget, en el cual forzaremos el envío de la lista de peliculas con el @required
  CardSwiper({ @required this.peliculas });

  @override
  Widget build(BuildContext context) {

    // Esta variable toma las caracteristicas del tamaño de la pantalla
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        // Definimos el 70% del ancho de la pantalla
        itemWidth: _screenSize.width * 0.6,
        // Definimos el 50% del alto de la pantalla
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context,int index){
          peliculas[index].uniqueId = '${ peliculas[index].id }-tarjeta';
          return Hero(
            tag: peliculas[index].uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GestureDetector(
                child: FadeInImage(
                  image: NetworkImage( peliculas[index].getPosterImg() ),
                  placeholder: AssetImage( 'assets/img/no-image.jpg' ),
                  fit: BoxFit.cover
                ),
                onTap: (){
                  //print(peliculas[index].title);
                  Navigator.pushNamed(context, 'detalle', arguments: peliculas[index]);
                },
              )
            ),
          );
        },
        itemCount: peliculas.length,
        //pagination: new SwiperPagination(),
        //control: new SwiperControl(),
      ),
    ); 
  }
}