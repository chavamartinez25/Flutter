import 'package:flutter/material.dart';


class LogIn extends StatelessWidget {

  final styleText = TextStyle(color: Colors.white, fontSize: 35.0);

  String _email = '';
  String _screenId= 'signup';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          _fondoApp(),
          Column(
            children: <Widget>[
              _logoApp(),
              _inputApp( context ),
            ],
          ),
          _logInApp( context ),

        ],
      ),
      
    );
  }


  Widget _fondoApp() {

    final _imageBackground = Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background_login.jpg'),
          fit: BoxFit.cover
        ), 
      ),
      child: null,
    );

    final _colorBackground =  Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(61, 62, 64, 0.3)
      ),
    );


    return Stack(
      children: <Widget>[
        _imageBackground,
        _colorBackground
      ],
    );

  }

  Widget _logoApp() {
    return Column(
      children: <Widget>[
        SizedBox(height: 100.0),
        Center(
          child: Hero(
            tag: _screenId,
            child: Image(
              image: AssetImage('assets/logo_2.png'),
              width: 100.0,
              height: 100.0,
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(height: 30.0),
        Center(
          child: Text('Log In', style: styleText),
        )
      ],
    );

  }

  Widget _inputApp( BuildContext context) {

    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.white,
        primaryColor: Colors.white,
        textTheme: Theme.of(context).textTheme.copyWith(caption: TextStyle(color: Colors.white)),
        textSelectionColor: Colors.white,
        primaryTextTheme: Theme.of(context).textTheme.copyWith(caption: TextStyle(color: Colors.white)),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: 50.0),
          Container(
            padding: EdgeInsets.only(right: 30.0,left: 30.0,bottom: 20.0),
            child: TextField(
              style: TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                hintText: 'Email',
                labelText: 'Email',
                suffixIcon: Icon(Icons.alternate_email,color: Colors.white),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 30.0,left: 30.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                hintText: 'Password',
                labelText: 'Password',
                suffixIcon: Icon(Icons.lock,color: Colors.white),
              ),
            ),
          ),
          Container(
            child: FlatButton(
              child: Text('Forgot your password?',style: TextStyle(color: Colors.white, fontSize: 13.0)),
              onPressed: (){},
            ),
            padding: EdgeInsets.only(right: 13.0),
            alignment: Alignment.topRight,
          )
        ],
      ),

    );
    
  }

  Widget _logInApp( BuildContext context) {

    return Column(
      children: <Widget>[
        SizedBox(height: 500.0),
        Center(
          child: RaisedButton(
            child: Text('Log In',style: TextStyle(fontSize: 16.0)),
            color: Color.fromRGBO(233, 200, 86, 1.0),
            onPressed: (){},
            textColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
              ),
            padding: EdgeInsets.fromLTRB(70.0, 13.0, 70.0, 13.0),
            elevation: 10,
            colorBrightness: Brightness.light,
          )
        ),
        SizedBox(height: 50.0),
        Center(
          child: Text('Do not have Account?',style: TextStyle(color: Colors.white, fontSize: 15.0)),
        ),
        Center(
          child: FlatButton(
            child: Text('Sign Up',style: TextStyle(color: Colors.white, fontSize: 15.0)),
            onPressed: (){
              Navigator.pushNamed(context, 'signup');
            },
          ),
        ),
        SizedBox(height: 50.0),
        Center(
          child: Text('GuideCar 2019 ©',style: TextStyle(color: Colors.white, fontSize: 15.0)),
        )
      ],
    );

  }

}