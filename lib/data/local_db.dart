import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:texno_bozor/data/models/news/news_model.dart';

class LocalDatabase {
  static final LocalDatabase getInstance = LocalDatabase._init();

  LocalDatabase._init();

  factory LocalDatabase() {
    return getInstance;
  }

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB("defaultDatabase.db");
      return _database!;
    }
  }

  Future<Database> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    const intType = "INTEGER DEFAULT 0";

    await db.execute('''
    CREATE TABLE ${NewsModelFields.newsTable}(
    ${NewsModelFields.id} $idType,
    ${NewsModelFields.newsTitle} $textType,
    ${NewsModelFields.newsBody} $textType,
    ${NewsModelFields.newsDataImg} $textType
    );
    ''');
  }

//-------------------------------NEWS SERVICE------------------------------------------
  static Future<NewsModel> insertNews(NewsModel newsModel) async {
    final db = await getInstance.database;
    final int id =
        await db.insert(NewsModelFields.newsTable, newsModel.toJson());
    return newsModel.copyWith(id: id);
  }

  static Future<List<NewsModel>> getAllNews() async {
    List<NewsModel> allNews = [];
    final db = await getInstance.database;
    allNews = (await db.query(NewsModelFields.newsTable))
        .map((e) => NewsModel.fromJson(e))
        .toList();

    return allNews;
  }

  static deleteNew(int id) async {
    final db = await getInstance.database;
    db.delete(
      NewsModelFields.newsTable,
      where: "${NewsModelFields.id} = ?",
      whereArgs: [id],
    );
  }

  static deleteAllNews() async {
    final db = await getInstance.database;
    db.delete(
      NewsModelFields.newsTable,
    );
  }
}
