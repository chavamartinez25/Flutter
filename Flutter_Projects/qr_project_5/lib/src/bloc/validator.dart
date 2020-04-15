import 'dart:async';

import 'package:qr_project_5/src/models/scann_model.dart';

class Validators {

  // Este es un Stream Transformer y su finalidad es que recibirá cierta información y sacará otra, rechazar informacion que no nos intereza
  final validarGeo = StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
    handleData: ( scans, sink ) {
      final geoScans = scans.where( (s) => s.tipo == 'geo').toList();
      sink.add(geoScans); 
    }
  );

    final validarHttp = StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
    handleData: ( scans, sink ) {
      final httpScans = scans.where( (s) => s.tipo == 'http').toList();
      sink.add(httpScans); 
    }
  );

}