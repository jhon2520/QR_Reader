import 'package:flutter/material.dart';

class UiProvier extends ChangeNotifier{

  //se crean los getter y setter para la 
  //propiedad que haga cambiar la página 

  int _selectedMenuOpt = 1;

  int get selectedMenuOpt
  {
    return this._selectedMenuOpt;
  }

  set selectedMenuOpt(int i)
  {
    this._selectedMenuOpt = i;
    //Notificar a cualquier Widget cuando cambie este valor
    notifyListeners();
  }

  

}