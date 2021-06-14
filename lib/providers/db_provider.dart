
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


//usando patron singleton

class DBProvider
{
  static Database? _database;

  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async{
    if(_database != null){return _database;}

    _database = await initiDB();

    return _database;
  }

  Future<Database> initiDB() async {

    //path de almacenamiento de la base
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //se une el path con el nombre de la base de datos que pongamos, es muy 
    //importante poner la extensión
    final path = join(documentsDirectory.path,"ScansDB.db");

    //crear base de datos

    //es importante colocar la versión por si hay cambios estructurales
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

}