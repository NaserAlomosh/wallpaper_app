// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  Database? database;
  Future<void> initDatabase() async {
    log('DATABASE');
    database = await openDatabase(
      'task.db',
      version: 1,
      onCreate: (Database db, int version) async {
        log('DATABASE 0');
        // When creating the db, create the table
        await db.execute(
            'CREATE TABLE Test (id INTEGER PRIMARY KEY, image TEXT, favorite TEXT , url TEXT)');
        log('DATABASE CREATED');
      },
      onOpen: (db) {
        log('DATABASE OPEN');
        //Open data base
        log('DATABASE OPEN');
      },
    );
  }

  Future<void> insertToDatabase(
      String? image, String? favorite, String? url) async {
    //
    await database!.transaction(
      (txn) async {
        await txn.rawInsert(
            'INSERT INTO Test(image, favorite ,url ) VALUES(?, ? ,?)', [
          image,
          favorite,
        ]).then(
          (value) {
            log('INSART DATABASE $value');
          },
        );
      },
    );
  }

  Future<List<Map>> getAll() async {
    if (database != null) {
      var allData = await database!.rawQuery('SELECT * FROM Test');
      print(allData);
      return allData;
    } else {
      print('data base is null');
      return [];
    }
  }

  void updateDatabase({String? image, String? favorite, int? id}) async {
    await database!.rawUpdate(
        'UPDATE Test SET image = ?, favorite = ?, WHERE id = ?',
        [image, favorite, id]);
  }

  Future<void> deleteDatabaseFromImage({String? image}) async {
    await database!.rawDelete('DELETE FROM Test WHERE image = ?', [image]);
  }

  Future<void> deleteDatabaseFromId({int? id}) async {
    await database!.rawDelete('DELETE FROM Test WHERE id = ?', [id]);
  }

  Future<int?> getCount() async {
    var x = await database!.rawQuery('SELECT COUNT (*) from Test');

    return x.length;
  }
}
