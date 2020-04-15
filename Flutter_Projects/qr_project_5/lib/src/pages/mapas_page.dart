import 'package:flutter/material.dart';
import 'package:qr_project_5/src/bloc/scans_bloc.dart';
import 'package:qr_project_5/src/models/scann_model.dart';

import 'package:qr_project_5/src/utils/utils.dart' as utils;


class MapasPage extends StatelessWidget {

  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    // Es necesario disparar el stream builder cada que se contruye la pantalla
    scansBloc.obtenerScans();

    return StreamBuilder<List<ScanModel>>(
      stream: scansBloc.scansStream, // En esta parte sustituimos la llamada de la base de datos por la llamada del stream
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if ( !snapshot.hasData ) {
          return Center( child: CircularProgressIndicator() );
        }

        final scans = snapshot.data;

        if ( scans.length == 0 ) {
          Center(
            child: Text('No hay información que mostrar')
          );
        }

        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (context, i) => Dismissible(
            key: UniqueKey(),
            background: Container(color: Colors.red),
            onDismissed: ( direction ) => scansBloc.borrarScan(scans[i].id),
            child: ListTile(
              leading: Icon( Icons.map, color: Theme.of(context).primaryColor ),
              title: Text( scans[i].valor ),
              subtitle: Text( 'ID: ${scans[i].id}' ),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
              onTap: () => utils.abrirScan(context,scans[i]),
            ),
          ),
        );
      },
    );
  }
}