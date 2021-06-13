import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/ui-provider.dart';

class CustomNavigationBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final uiProvider = Provider.of<UiProvier>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    return BottomNavigationBar(
      //Hacer que el valor del selectedMenuOpt
      //cambie cuando se presiona el bottom
      
      onTap: (int i)=> uiProvider.selectedMenuOpt = i,
      elevation: 0,
      currentIndex: currentIndex,
      items: 
    <BottomNavigationBarItem>[

      BottomNavigationBarItem(
        icon: Icon(Icons.map),
        label: "Mapa" 
        ),
      BottomNavigationBarItem(
        icon: Icon(Icons.compass_calibration),
        label: "Direcciones" 
        ),
      
    ]);
  }
}