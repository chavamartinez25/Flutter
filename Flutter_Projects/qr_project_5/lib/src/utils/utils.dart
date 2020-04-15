import 'package:flutter/material.dart';

import 'package:qr_project_5/src/providers/db_provider.dart';
import 'package:url_launcher/url_launcher.dart';



abrirScan(BuildContext context, ScanModel scan ) async {

  if (scan.tipo == 'http'){

    if (await canLaunch( scan.valor )) {
    await launch( scan.valor );
    } else {
      throw 'Could not launch ${scan.valor}';
    }

  } else {
    // En la parte de arguments enviamos todo el scan para sustraer la información de las coordenadas a localizar en el mapa
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }
  
  
}