import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/home_paget.dart';
import 'package:qr_reader/pages/mapa_page.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui-provider.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
 //se envuelve todo el martialApp en el provider
 //el cual es el gestor de estado 
    return MultiProvider(

          //instrucción que se ejecuta cuando no hay ninguna estancia del provider
          //recibe el buildcontext pero no se necesita entonce uso (_)
      providers: [
        ChangeNotifierProvider(create: (_) => new UiProvier()),
        ChangeNotifierProvider(create: (_) => new ScanListProvider())
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Qr Reader",
        initialRoute: "home",
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.deepPurple)
        ),
        routes: {
          "home": (_) => HomePage(),
          "mapa": (_) => MapaPage()
        },
      ),
    );
  }
}