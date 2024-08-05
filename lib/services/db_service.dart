import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:test_skuad/models/article_model.dart';

class DbService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'articles.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE articles(title TEXT, author TEXT, createdAt TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertArticle(Article article) async {
    final db = await database;
    await db.insert(
      'articles',
      article.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Article>> getArticles() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('articles');

    return List.generate(maps.length, (i) {
      return Article(
        title: maps[i]['title'],
        author: maps[i]['author'],
        createdAt: DateTime.parse(maps[i]['createdAt']),
      );
    });
  }
}
