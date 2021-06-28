    import 'package:flutter/cupertino.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';


launchURL(BuildContext context, ScanModel scan) async {

    final String url = scan.valor;

    if(scan.tipo == "http")
    {
      await canLaunch(url) 
      ? await launch(url) 
      : throw 'Could not launch $url';
    }
    else
    {
      Navigator.pushNamed(context, "mapa", arguments: scan);
    }


}
