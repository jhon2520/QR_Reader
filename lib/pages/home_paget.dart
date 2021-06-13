import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/direcciones_page.dart';
import 'package:qr_reader/pages/mapas_page.dart';
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
          IconButton(onPressed: () {}, icon: Icon(Icons.delete_forever))
        ],
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


    //cambiar para mostrar la página respectiva
    final currentindex = uiProvider.selectedMenuOpt;

    switch(currentindex){

      case 0:
      return MapasPage();

      case 1:
      return DireccionesPage();

      default:
      return MapasPage();
    } 

  }
}