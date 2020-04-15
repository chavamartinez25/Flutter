import 'dart:async';



class Validators {


  // En el Stream es importante definir qué sara lo que entray que es lo que sale, en este caso entra un String y sale un String
  final validarEmail  = StreamTransformer<String, String>.fromHandlers(
    // El sink indica que información esta fluyendo o que información es erronea y se necesita bloquear
    handleData: ( email, sink ){
      // Esta expresion regular validará el correo electrónico
      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp   = new RegExp(pattern);

      if ( regExp.hasMatch( email ) ){
        sink.add(email);
      } else {
        sink.addError('El email no es correcto');
      }

    }
  );

  // En el Stream es importante definir qué sara lo que entray que es lo que sale, en este caso entra un String y sale un String
  final validarPassword  = StreamTransformer<String, String>.fromHandlers(
    // El sink indica que información esta fluyendo o que información es erronea y se necesita bloquear
    handleData: ( password, sink ){

      if( password.length >= 6 ) {
        sink.add( password );
      } else {
        sink.addError('La contraseña debe tener mínimo 6 caracteres');
      }

    }
  );

}