import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      currentIndex: 0,
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