import 'dart:async';

import 'package:form_validation_project7/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

// Le asignamos a la clase bloc un Mixin, por eso la palabra reservada with para otorgarle las propiedades del validators
class LoginBloc with Validators {

  final _emailController    = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // Recuperar los datos del Stream
  Stream<String> get emailStream    => _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);

  // Combinacion de los dos Streams a traves de la librería rxdart y retorna (e, p) => true si se retorno algo correctamente
  Stream<bool> get formValidStream => 
      Observable.combineLatest2(emailStream, passwordStream, (e,p) => true);

  // Insertar valores al Stream
  Function(String) get changeEmail    => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  // Obtener el ultimo valor deseado a los Strings
  String get email    => _emailController.value;
  String get password => _passwordController.value;

  // Cierre de Streams cuando ya no son escuchados
  dispose() {
    _emailController?.close();
    _passwordController?.close();
  }

}