import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {

  String _screenId= 'signup';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: <Widget>[
          _fondApp(),
          _appBar( context ),
          //_userPhotoApp(),
          _formularioApp(),
        ],
      ), 
    );
  }

  Widget _appBar( BuildContext context ) {

    final _decorationAppBar = BoxDecoration(
      gradient: LinearGradient(
        begin: FractionalOffset( 0.0, 0.6 ),
        end: FractionalOffset( 0.0, 2.0 ),
        colors: [
          Color.fromRGBO(37, 37, 36, 0.9),
          Color.fromRGBO(50, 50, 50, 0.2),
          Color.fromRGBO(79, 79, 77, 0.2),
        ]
      )
    );


    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      decoration: _decorationAppBar,
      child: Row(
        children: <Widget>[
          FlatButton(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Icon(
                Icons.arrow_back_ios, 
                color: Colors.white,
                size: 20.0,
              ),
            ),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 92.0),
            child: Text(
              'Sign Up', 
              style: TextStyle(fontSize: 19.0, color: Colors.white)
            ),
          ),
          Hero(
            tag: _screenId,
            child: Image(
              image: AssetImage('assets/logo_2.png'),
              width: 50.0,
              height: 50.0,
            ),
          ),
        ],
      )
    );
  }

  Widget _fondApp() {
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

  Widget _userPhotoApp() {

  }

  Widget _formularioApp() {

    final inputs = SingleChildScrollView(
      child:Column(
        children: <Widget>[
          SizedBox(height: 100.0),
            Container(
                padding: EdgeInsets.only(right: 30.0,left: 30.0,bottom: 20.0),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    hintText: 'Name',
                    labelText: 'Name',
                    suffixIcon: Icon(Icons.group,color: Colors.white),
                  ),
                ),
            ),
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
                    hintText: 'E-mail',
                    labelText: 'E-mail',
                    suffixIcon: Icon(Icons.email,color: Colors.white),
                  ),
                ),
            ),
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
                    hintText: 'Password',
                    labelText: 'Password',
                    suffixIcon: Icon(Icons.lock,color: Colors.white),
                  ),
                ),
            ),
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
                    hintText: 'Confirm password',
                    labelText: 'Confirm password',
                    suffixIcon: Icon(Icons.lock,color: Colors.white),
                  ),
                ),
            ),
        ],
      ) ,
    );
    
    

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 120.0),
            child: Center(
              child: Text('Create new acount',style: TextStyle(color: Colors.white, fontSize: 30.0)),
            ),
          ),
          inputs
        ],
      ),
    );

  }

}