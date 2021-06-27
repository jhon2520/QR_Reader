
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:qr_reader/models/scan_model.dart';
//el export es para utilizar el paquete en todos lados
export 'package:qr_reader/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


//usando patron singleton

class DBProvider
{
 //La clase tiene un atributo de tipo Database que cuando se instancia, y se quiera accerder
 //A la propiedad _database a través del getter se validad si ya hay una base creada entonces se usa la
 //creada si no, se crea una nueva por primera y única vez

  static Database? _database;

  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async{
    if(_database != null){return _database;}
    _database = await initiDB();
    return _database;
  }

  // ** Creación de la base de datos
  Future<Database> initiDB() async {

    //path de almacenamiento de la base
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //se une el path con el nombre de la base de datos que pongamos, es muy 
    //importante poner la extensión
    final path = join(documentsDirectory.path,"ScansDB.db");
    print(path);

    //crear base de datos

    // es importante colocar la versión por si hay cambios estructurales
    //y se requiere crear una nueva base
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){},
      onCreate: (Database db, int version ) async {

          await db.execute('''
          
            CREATE TABLE Scans(
              id INTEGER PRIMARY KEY,
              tipo TEXT,
              valor TEXT
            )
          
          ''');
      }
      ); 

  }

  // ** Métodos para interactuar con la base de datos

// ! FORMA 1

  Future<int> nuevoScanRaw(ScanModel nuevoScan) async{

    final id    = nuevoScan.id;
    final tipo  = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    //Verificar la base de datos
    final db = await database;
    final respuesta = await db!.rawInsert('''
    
      INSERTO INTO Scans(id,tipo,valor)
      VALUES('$id','$tipo','$valor')
    
    ''');
    //Como la respuesta es de tipo entero, se devolverá un future de enteros
    //retorna el ID del último registro insertado 
    return respuesta;
  }

  // ! Forma 2

  Future<int> nuevoSCan(ScanModel nuevoScan) async {

    final db = await database;
    final respuesta = await db!.insert("Scans", nuevoScan.toJson());
    //retorna el ID del último registro insertado
    return respuesta;

  }

  //Obtener información según un ID

  Future<ScanModel?> getScanById(int idScan) async{

    final db = await database;
    //La siguiente es una forma de ejecutar un query, si el where tuviera varios argumentos
    //el where args los mandaría de manera posicional, ejemplo 
    // Wehre: "id = ? and tipo = ?", whereArgs:[Argumento para id, argumento para tipo]
    final respuesta = await db!.query("Scans", where: "id=?",whereArgs: [idScan]);
    return respuesta.isNotEmpty ? ScanModel.fromJson(respuesta.first) :null;
  }

  //Obtener todos los scans
    Future<List<ScanModel>?> getAllScans() async{
    final db = await database;
    final respuesta = await db!.query("Scans");
    return respuesta.isNotEmpty ? respuesta.map((s) => ScanModel.fromJson(s)).toList() :[];
  }

  //Obtener todos los scans
    Future<List<ScanModel>?> getScansPorTipo(String tipo) async{

      final db = await database;
      final respuesta = await db!.rawQuery('''
      SELECT * FROM Scans WHERE tipo = "$tipo"
      ''');
      return respuesta.isNotEmpty
        ? respuesta.map((scan) => ScanModel.fromJson(scan)).toList():[]; 
 
  }

  //Actualizar registro

   Future updateScan(ScanModel nuevoScan) async{

     final db = await database;
     final respuesta = await db!.update("Scans", nuevoScan.toJson(), where: "id = ?",whereArgs: [nuevoScan.id] );
    return respuesta;
  }

  //Eliminar regirstro

  Future<int> deleteScan(int id) async{
    final db = await database;
    final respuesta = await db!.delete("Scans", where: "id = ?", whereArgs: [id]);
    return respuesta;

  }

  Future<int> deleteAllScans() async{

    final db = await database;
    final respuesta = db!.rawDelete('''
    DELETE FROM Scans
    ''');

    return respuesta;
  }

}