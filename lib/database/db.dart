import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/produit.dart';

class DB {


  final int version = 1;
  Database db;
  var table="cproduit";

  static final DB _dbHelper = DB._internal();



  DB._internal();
  factory DB() {
    return _dbHelper;
  }


  Future<Database> openDb() async {
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), 'sums.db'),
          onCreate: (database, version) {
        database.execute(
            'CREATE TABLE produit(id INTEGER PRIMARY KEY, nom TEXT, prix TEXT, image TEXT)');
        database.execute(
            'CREATE TABLE cproduit( nom TEXT, prix TEXT, idUser TEXT, qte TEXT)');
      }, version: version);
      print("db created");
    }
    return db;
  }



  Future<int> insertProduit(Produit list) async {
    return await db.insert(
      'produit',
      list.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }



  Future<int> insertCProduit(CProduit list) async {
    print("inserted commande ${list.nom} $db");
    return await db.insert(
      table,
      list.toMap(),
    );
  }



  Future<List<Produit>> getProduit() async {
    final List<Map<String, dynamic>> maps = await db.query('produit');
    return List.generate(maps.length, (i) {
      return Produit(
        maps[i]['id'],
        maps[i]['name'],
        maps[i]['prix'],
        maps[i]['image'],
      );
    });
  }



  Future<List<CProduit>> getCProduit() async {
    final List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(maps.length, (i) {
      return CProduit(
        maps[i]['nom'],
        maps[i]['prix'],
        maps[i]['idUser'],
        maps[i]['qte'],
      );
    });
  }




  Future<List<CProduit>> fetchCprod() async {

    final db = await openDb();
    final maps = await db
        .query(table); 

    return List.generate(maps.length, (i) {
 
      return CProduit(
        maps[i]['nom'],
        maps[i]['prix'],
        maps[i]['idUser'],
        maps[i]['qte'],
      );
    });
  }




  Future<int> deleteCProd(var id) async {
    final db = await openDb();

    int result = await db.delete(table, 
        where: "nom = ?",
        whereArgs: [id] 
        );
    print("valeur renvoye $result");
    return result;
  }




  Future<int> deleteAllCProd() async {
    final db = await openDb();

    int result = await db.delete(
      table, 
    );
    print("valeur renvoye $result");
    return result;
  }



}
