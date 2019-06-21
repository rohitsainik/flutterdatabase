import 'dart:async';
import '../model/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instances = new DatabaseHelper.internal();
  String dbtable = "Usertable";
  String username = "Username";
  String password = "Userpassword";
  String id = "Userid";

  factory DatabaseHelper() {
    return _instances;
  }

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initdb();
    return _db;
  }

  DatabaseHelper.internal();

  initdb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "main.db");

    var outDB = await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $dbtable($id INTEGER PRIMARY KEY,$username TEXT,$password TEXT  )");
  }
  Future<int> Saveuser(User user) async {
    var dbClient = await db;
    int res = await dbClient.insert("$dbtable", user.toMap());
    return res;
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) FROM $dbtable"));
  }

  Future<List> getUser() async{
    var dbClient = await db;
    return await dbClient.rawQuery("SELECT * FROM $dbtable");
  }

  Future<int> deleteuser(int id) async{
    var dbClient = await db;
    return await dbClient.delete(dbtable,where: "$id = ?",whereArgs: [id] );
  }

  Future<int> update(User user) async{
    var dbClient = await db;
    var up= await dbClient.update(dbtable, user.toMap(),where: "$id = ?", whereArgs: [user.Id] );
    return up;
  }



}
