import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/item.dart';
import '../models/password.dart';
//import 'package:intl/intl.dart';



class DbHelper {

  Database db;    

  Future<Database> get openDB async {
    db = await openDatabase(join(await getDatabasesPath(), 'manager.db'), onCreate: (database, version) {
      database.execute('CREATE TABLE tbl_item (id INTEGER PRIMARY KEY, name TEXT, date TEXT)');
      database.execute('CREATE TABLE tbl_password (id INTEGER PRIMARY KEY, list_id INTEGER, username TEXT, password TEXT, date TEXT, FOREIGN KEY (list_id) REFERENCES tbl_list(id))');
    }, version: 1);
    return db;
  }

  Future testDB() async {
    db = await openDB;
    await db.execute('INSERT INTO tbl_item (name, date) VALUES ("Hello2", "${DateTime.now()}")');
    await db.execute('INSERT INTO tbl_password VALUES (null, 0, "nat", "12345", "${DateTime.now()}")');
    List list = await db.rawQuery('SELECT * FROM tbl_item');
    List password = await db.rawQuery('SELECT * FROM tbl_password');
    print(list.toString());
    print(password.toString());
  }


  Future<int> insertItem(Item item) async {
    db = await openDB;
    int id = await db.insert('tbl_item', item.toMap());
    return id;
  }

  Future<List<Item>> getItem() async {
    db = await openDB;
    List<Map<String, dynamic>> list = await db.query('tbl_item');
    return List.generate(list.length, (index) {
      return Item(id: list[index]['id'], name: list[index]['name'], date: list[index]['date']);
    });
  }

  Future<List<Password>> getAccount(int id) async {
    db = await openDB;
    List<Map<String, dynamic>> list = await db.query('tbl_password', where: "list_id = ?", whereArgs: [id]);
    return List.generate(list.length, (index) {
      return Password(id: list[index]['id'], listId: list[index]['list_id'], username: list[index]['username'], password: list[index]['password'], date: list[index]['date']);
    });
  }

  Future<int> insertAccount(Password password) async {
    db = await openDB;
    int id = await db.rawInsert('INSERT INTO tbl_password (list_id, username, password, date) VALUES (?, ?, ?, ?)', [password.listId, password.username, password.password, password.date]);
    print(id);
    return id;
  }

  Future<int> deleteItem(Item item) async {
    db = await openDB;
    int id = await db.delete('tbl_item', where: "id = ?", whereArgs: [item.id]);
    await deleteAssociatedAccount(db, item.id);
    return id;
  }

  Future deleteAssociatedAccount(Database db, int id) async {
    await db.delete('tbl_password', where: "list_id = ?", whereArgs: [id]);
  }

  Future<int> deleteAccount(Password password) async {
    db = await openDB;
    int id = await db.delete('tbl_password', where: "id = ?", whereArgs: [password.id]);
    return id;
  }

  Future printItem() async {
    db = await openDB;
    List<Map<String, dynamic>> list = await db.query('tbl_item');
    print(list);
  }


}