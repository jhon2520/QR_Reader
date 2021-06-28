//import 'dart:convert';

// ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));

// String scanModelToJson(ScanModel data) => json.encode(data.toJson());

import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class ScanModel {
    
    int? id;
    String? tipo;
    String valor;
    
    ScanModel({this.id,this.tipo,required this.valor,})
    {
      if(this.valor.contains("http"))
      {
        this.tipo = "http";
      }
      else
      {
        this.tipo = "geo"; 
      }
    }

    //el siguiente método coge un json con las características del
    //scan model y crea una nueva instancia de ScanModel
    factory ScanModel.fromJson(Map<String, dynamic> json)
    {
      return     ScanModel(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
    );
    }
    
    //coge la instancia de la clase y la convierte en un mapa
    Map<String, dynamic> toJson() 
    { 
      return   {
                "id": id,
                "tipo": tipo,
                "valor": valor,
              };
    }

    LatLng getLatLng(){

      final latLng = this.valor.substring(4).split(",");
      final lat = double.parse(latLng[0]);
      final lng = double.parse(latLng[1]);

      return LatLng(lat, lng);

    }
  
}
