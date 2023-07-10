import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DatabaseHelper {
  static final _databaseName = 'usuarios.db';
  static final _databaseVersion = 1;

  static final table = 'usuarios';
  static final columnId = 'id';
  static final columnEmail = 'email';
  static final columnPassword = 'password';

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getDatabasesPath();
    final path = join(documentsDirectory, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnEmail TEXT NOT NULL,
        $columnPassword TEXT NOT NULL
      )
      ''');
  }

  Future<int> insertUser(User user) async {
    final db = await database;
    return await db.insert(table, user.toMap());
  }

  Future<List<User>> getUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(table);

    return List.generate(maps.length, (i) {
      return User(
        id: maps[i][columnId],
        email: maps[i][columnEmail],
        password: maps[i][columnPassword],
      );
    });
  }
}
class User {
  int id;
  String email;
  String password;

  User({required this.id, required this.email, required this.password});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
    };
  }
}
