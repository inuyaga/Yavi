import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:yavi/models/producto.dart';

const String tableName = "productos";
const String dataBaseName = "yavi.db";

class ProductoProvider {
  late Database _dataDB;
  Future<Database> get database async {
    _dataDB = await openDatabase(
      join(await getDatabasesPath(), dataBaseName),
      version: 1,
      onCreate: (db, version) async {
        await productoExecute(db, version);
      },
    );
    return _dataDB;
  }

  // deleteDB() async {
  //   await deleteDatabase(join(await getDatabasesPath(), dataBaseName));
  // }

  Future<Producto> insert(Producto producto) async {
    final db = await database;
    producto.id = await db.insert(tableName, producto.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    return producto;
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(tableName);
    return maps;
  }

  Future<Producto?> getProducto(int id) async {
    final db = await database;
    List<Map<String, dynamic>> maps =
        await db.query(tableName, where: 'id = $id');

    if (maps.isNotEmpty) {
      return Producto.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getProductoFilter(String search) async {
    final db = await database;
    List<Map<String, dynamic>> maps = [];
    if (search.isNotEmpty) {
      maps = await db.query(tableName, where: 'nombre LIKE "%$search%" ');
    }
    return maps;
  }
}

Future<void> productoExecute(db, version) async {
  await db.execute(
    '''CREATE TABLE $tableName( "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
                                      "nombre" TEXT(100),
                                      "descripcion" TEXT(350),
                                      "precio" real, 
                                      "precioCosto" real,  
                                      "codebar" TEXT(250),  
                                      "img" TEXT(250) )''',
  );
}
