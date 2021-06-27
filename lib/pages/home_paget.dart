
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/direcciones_page.dart';
import 'package:qr_reader/pages/mapas_page.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui-provider.dart';
import 'package:qr_reader/widgets/custom_navigatorbar.dart';
import 'package:qr_reader/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Historial"),
        actions: [
          IconButton(
          icon: Icon(Icons.delete_forever),
          onPressed: () {

            //Método para eliminar todo, como estoy dentro de un método
            //onpressed y no debajo del build lo normal es que no tenga que redibujar
            Provider.of<ScanListProvider>(context,listen: false).borrarTodos();

          }, 
          )],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {

  @override

  //desde el context puedo acceder al provider
  Widget build(BuildContext context) {


    //obtener el selectedMenuOpt

    final uiProvider = Provider.of<UiProvier>(context);
  /*
   final tempScan = new ScanModel(valor: "https://www.123.com/");
    DBProvider.db.nuevoSCan(tempScan);
    DBProvider.db.deleteAllScans().then(print);
*/
    //usar el scanlistprovider

    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);


    //cambiar para mostrar la página respectiva
    final currentindex = uiProvider.selectedMenuOpt;

    switch(currentindex){

      case 0:
      scanListProvider.cargarScanPorTipo("geo");
      return MapasPage();

      case 1:
      scanListProvider.cargarScanPorTipo("http");
      return DireccionesPage();

      default:
      return MapasPage();
    } 

  }
}