import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapaPage extends StatefulWidget {

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {

  Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context)!.settings.arguments as ScanModel;
    //recibir información del navigator.pushnamed

      //Codigo que usa el ejemplo en https://pub.dev/packages/google_maps_flutter
     final CameraPosition puntoInicial = CameraPosition(
      bearing: 192.8334901395799,
      target: scan.getLatLng(),
      tilt: 50,
      zoom: 20);

      //Marcadores

      Set<Marker> marker = new Set<Marker>();
      marker.add(new Marker(
        markerId: MarkerId("geo-location"),
        position: scan.getLatLng(),
        
        ),
        );



    return Scaffold(
      appBar: AppBar(
        actions: [
          //Boton que me retorna al marcador
          IconButton(onPressed: () async{

            final GoogleMapController controller = await _controller.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(target: scan.getLatLng(),
              tilt: 50,
              zoom: 20)
            ));

          }, 
          icon: Icon(Icons.location_city_sharp))
        ],
        title: Text("Mapa"),
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        mapType: mapType,
        markers: marker,
        initialCameraPosition: puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.layers),
        onPressed: (){
          
          setState(() {
            
            if(this.mapType == MapType.normal){mapType = MapType.satellite;}
            else{mapType = MapType.normal;}

          });

        },
      ),
    );
  }
}

