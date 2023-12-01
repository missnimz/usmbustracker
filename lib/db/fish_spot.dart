import 'package:nelayannet/Model/fishing_spot.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Fishing_spot_Database{
  static final Fishing_spot_Database instances = Fishing_spot_Database._init();
  static Database? _database;

  Fishing_spot_Database._init();

  Future<Database> get database async{
    if (_database!=null) return _database!;

    _database = await _initDB('fish_spot.db');

    return _database!;
  }

  Future<Database> _initDB(String filePath) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

  return await openDatabase(path, version: 1, onCreate: (Database db, int version) async{

    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';
    const doubleType = 'REAL NOT NULL';

    
    await db.execute('''
CREATE TABLE $tableSpot (
  ${SpotFields.id} $idType,
  ${SpotFields.name} $textType,
  ${SpotFields.longitude} $doubleType,
  ${SpotFields.latitude} $doubleType,
  ${SpotFields.time} $textType
)

    ''');

  });

  }

  Future<Spot> create (Spot spot) async {
    final db = await instances.database;

    final id = await db.insert(tableSpot, spot.toJson());

    return spot.copy(id: id);
  }
  
  Future<Spot> readSpot (int id) async {
    final db = await instances.database;

    final maps = await db.query(
      tableSpot,
      columns: SpotFields.values,
      where: '${SpotFields.id} ?',
      whereArgs: [id],

    );

    if (maps.isNotEmpty){
      return Spot.fromJson(maps.first);
    } else {
      throw Exception('$id not found');
    }

  }

  Future<List<Spot>> readAllSpot (String userName) async{
    final db = await instances.database;

    final result = await db.query(
      tableSpot,
      columns: SpotFields.values,
      where: '${SpotFields.name} = ?',
      whereArgs: [userName],

    );

    return result.map((json) => Spot.fromJson(json)).toList();

  }

  Future<int> update(Spot spot) async {
    final db = await instances.database;

    return db.update(
      tableSpot,
      spot.toJson(),
      where: '${SpotFields.id} = ?',
      whereArgs: [spot.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instances.database;

    return await db.delete(
      tableSpot,
      where: '${SpotFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {

    final db = await instances.database;

    db.close();
  }

}

