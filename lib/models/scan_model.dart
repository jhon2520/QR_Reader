//import 'dart:convert';

// ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));

// String scanModelToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {
    
    int id;
    String tipo;
    String valor;
    
    ScanModel({required this.id,required this.tipo,required this.valor,})
    {
      if(this.tipo.contains("http"))
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
    factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
    );
    //coge la instancia de la clase y la convierte en un mapa
    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
    };
}
