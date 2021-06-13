import 'package:flutter/material.dart';
import 'package:qr_reader/pages/home_paget.dart';
import 'package:qr_reader/pages/mapa_page.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: "Qr Reader",
      initialRoute: "home",
      routes: {
        "home": (_) => HomePage(),
        "mapa": (_) => MapaPage()
      },
    );
  }
}