
import 'package:flutter/material.dart';
import 'package:form_validation_project7/src/bloc/login_bloc.dart';
export 'package:form_validation_project7/src/bloc/login_bloc.dart';



class Provider extends InheritedWidget {

  static Provider _instancia;
  // La tarea del factory es determinar si necesito enviar una nueva instancia de la clase o se envía una existente
  factory Provider({ Key key, Widget child }) {

    if ( _instancia == null ) {
      _instancia = new Provider._internal(key: key, child: child);
    }

    return _instancia;

  }

  // Este es el constructor, recibe una llave del widget, tambien recibe un hijo de tipo Widget que puede ser lo que sea a escuchar
  Provider._internal({ Key key, Widget child })
    : super(key: key, child: child);

  // Esta es la propiedad global a manejar en la aplicacion
  final loginBloc = LoginBloc();

  // Este es el constructor, recibe una llave del widget, tambien recibe un hijo de tipo Widget que puede ser lo que sea a escuchar
  // Provider({ Key key, Widget child })
  //   : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of ( BuildContext context ) {
    // Ira a buscar la instancia del provider en el contexto. El contexto es el arbol de widgets
    return ( context.inheritFromWidgetOfExactType(Provider) as Provider ).loginBloc;
  }

}