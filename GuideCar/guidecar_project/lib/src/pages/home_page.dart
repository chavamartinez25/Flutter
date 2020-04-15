import 'package:flutter/material.dart';
import 'package:guidecar_project/src/pages/login/help_page.dart';
import 'package:guidecar_project/src/pages/micar_page.dart';
import 'package:guidecar_project/src/pages/settings_page.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Solicitar ayuda'),
        backgroundColor: Colors.blue,
      ),
      body: _callPage( currentIndex ),
      bottomNavigationBar: _crearBottomNavigationBar(),
      floatingActionButton: _crearFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _crearBottomNavigationBar() {

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index){
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.drive_eta),
          title: Text('Mi car')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          title: Text('Settings')
        )
      ],
    );
  }

  Widget _callPage( int paginaActual ) {
    switch ( paginaActual ){
      case 0  : return MiCar();
      case 1  : return SettingsPage();
      case 3  : return HelpPage();

      default : return HelpPage();
    }
    
  }

  Widget _crearFloatingActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.highlight),
      onPressed: (){
        setState(() {
          print('Hacia el Help page');
          HelpPage();
        });
      },
    );
  }

}