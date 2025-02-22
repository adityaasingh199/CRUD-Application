import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{
  /// make this class constructor private
  /// private constructor

  static const String TABLE_NAME = 'notes';
  static const String COLUMN_ID = 'nID';
  static const String COLUMN_TITLE = 'nTitle';
  static const String COLUMN_DESC = 'nDesc';
  static const String COLUMN_CREATED_AT = 'nCreatedAt';

  DbHelper._();
  static DbHelper getIns() => DbHelper._();

  ///go to the database path if db is present than open if not present db that path so than created db than open
  Database? _Db;

  Future<Database> getDb() async{

    _Db ??= await CreateDb();
    return _Db!;

   /* if(_Db!=null){
      return _Db!;
    }else{
      _Db= await CreateDb();
      return _Db!;
    }*/
  }

  Future<Database> CreateDb() async{

    Directory appDoc = await getApplicationDocumentsDirectory();
    String dbPath = join(appDoc.path,"notesDB.db");

    return await openDatabase(dbPath,version: 1, onCreate: (db,version){
      ///create Table
      db.execute("CREATE TABLE $TABLE_NAME ($COLUMN_ID integer primary key autoincrement,$COLUMN_TITLE text,$COLUMN_DESC text,$COLUMN_CREATED_AT text)");
    });
  }

  Future<bool> addNote({required String title,required String desc})async{
    Database db = await getDb();
    
    int rowsEffected = await db.insert(TABLE_NAME, {
      COLUMN_TITLE: title,
      COLUMN_DESC: desc,
      COLUMN_CREATED_AT:DateTime.now().millisecondsSinceEpoch.toString(),

    });
    return rowsEffected>0;
  }
  Future<List<Map<String,dynamic>>> fetchAllNotes()async{
    var db = await getDb();
    List<Map<String,dynamic>> mNotes = await db.query(TABLE_NAME);
    return mNotes;
  }
  Future<bool> updatesNotes({required int id, required String title, required String desc})async{
    var db = await getDb();
    int rowsEffected = await db.update(TABLE_NAME, {
      COLUMN_TITLE:title,
      COLUMN_DESC: desc
    },where: "$COLUMN_ID=?",whereArgs: ["$id"]);
    return rowsEffected>0;
  }
  Future<bool>deleteNote(int id)async{
    var db = await getDb();

    int rowsEffected = await db.delete(TABLE_NAME,where: "$COLUMN_ID=$id");
    return rowsEffected>0;
  }

}
