

import 'package:flutter/cupertino.dart';
import 'package:qr_reader/providers/db_provider.dart';


// ** todo lo que va a hacer la siguiente clase es insertar un nuevo scans
// ** en la base de datos validando si es una dirección http o un mapa

class ScanListProvider extends ChangeNotifier{

  List<ScanModel> scans = [];
  String tipoSeleccionado = "http";

Future nuevoScan(String valor) async {

  final nuevoScan = new ScanModel(valor: valor);
  final id = await DBProvider.db.nuevoSCan(nuevoScan);
  //Asignar el id de la base de datos al modelo
  nuevoScan.id = id;

  //si se agrega una dirección hgttp nueva se actualiza 
  //la interfaz de usuario, si se agrega una nueva cordenada de mapa no es
  //necesario actualizar la interfaz


  if(this.tipoSeleccionado == nuevoScan.tipo)
  {
    this.scans.add(nuevoScan);
    notifyListeners();
  }
}

cargarScans() async {
  final scans = await DBProvider.db.getAllScans();
  this.scans = [...scans!];
  notifyListeners();
}
cargarScanPorTipo(String tipo) async{

  final scans = await DBProvider.db.getScansPorTipo(tipo);
  this.scans = [...scans!];
  this.tipoSeleccionado = tipo;
  notifyListeners();
}

borrarTodos()async{

  await DBProvider.db.deleteAllScans();
  this.scans = [];
  notifyListeners();
}

borrarScanPorId(int id) async{
  await DBProvider.db.deleteScan(id);
 
} 



}

