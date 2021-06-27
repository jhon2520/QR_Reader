import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';

class ScanTiles extends StatelessWidget {

  final String tipo;

  const ScanTiles({required this.tipo});

  @override
  Widget build(BuildContext context) {
     //Esta ventana si necesito que se redibuje
    // !!! USUALMENTE se puede saber que se quiere rebibujar porque estoy dentro
    // !!! de un método build, dentro de otro método, normalmente va en false
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;


    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, i){

        //un dismissible permite eliminar uno de los elementos del 
        //listtittle usando Uniquekey() que es un método propio de flutter que crea
        // una llave única para cada elemento
        return Dismissible(
          key: UniqueKey(),
          background: Container(
            color: Theme.of(context).primaryColor,
          ),
          //Actualizar la base de datos cuando un elemento sea eliminado
          onDismissed: (DismissDirection direction){
              Provider.of<ScanListProvider>(context, listen: false).borrarScanPorId(scans[i].id!);
          },
          child: ListTile(
            leading: Icon(
              this.tipo == "http" 
              ? Icons.home_outlined
              : Icons.map_outlined, 
              color: Theme.of(context).primaryColor,),
            title: Text(scans[i].valor),
            subtitle: Text(scans[i].id.toString()),
            trailing: Icon(Icons.keyboard_arrow_right_rounded, color: Theme.of(context).primaryColor,),
            onTap: ()=> print(scans[i].id),
          ),
        );
      });
  }
}