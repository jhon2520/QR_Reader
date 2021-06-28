import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';
//import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';


class ScanButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      onPressed: () async{

        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode("#3D8BEF", "Cancelar", false, ScanMode.QR);
       // String barcodeScanRes = "https://www.google.com/"; 
       // String barcodeScanRes = "geo:6.227268116339072,-75.54700523835699"; 

        //si el usuario cancela
        if(barcodeScanRes == "-1"){return;}

        //Como estoy dentro de este método no necesito que se redibuje
        final scanListProvider = Provider.of<ScanListProvider>(context,listen: false);
        final nuevoScan = await scanListProvider.nuevoScan(barcodeScanRes);
        launchURL(context, nuevoScan);
      },
      child: Icon(Icons.filter_center_focus_outlined),);
  }
}