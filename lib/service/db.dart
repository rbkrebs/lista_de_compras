import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class BancoDeDados {
  static final BancoDeDados? _instance = BancoDeDados._();
  BancoDeDados._();
  Database? db;

  String sql =
      "CREATE TABLE item ( id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, descricao TEXT, valor TEXT, imagem TEXT, lat TEXT, long TEXT)";
  factory BancoDeDados() {
    return _instance!;
  }

  Future<void> onCreate(Database db, int version) async {
    db.execute(sql);
  }

  Future<void> openDb() async {
    return await getDatabasesPath().then((androidPath) async {
      String path = androidPath + '/exemplo.db';
      db = await openDatabase(path, version: 1, onCreate: onCreate);
    });
  }
}
