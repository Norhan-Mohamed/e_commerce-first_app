import 'package:e_commerce/network/dataBaseModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String _favTable = 'FavTable';

class FavDataProvider {
  late Database db;

  static final FavDataProvider instance = FavDataProvider._internal();

  factory FavDataProvider() {
    return instance;
  }
  FavDataProvider._internal();

  Future open() async {
    db = await openDatabase(join(await getDatabasesPath(), 'fav.db'),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
create table $_favTable ( 
$columnid integer primary key,
$columnname text not null,
$columnimageUrl text ,
$columncolour text ,
$columncolourWayId text ,
$columnbrandName text ,
$columnprice real

  )
''');
    });
  }

  Future<List<DataBaseModel>> getData() async {
    List<Map<String, dynamic>> maps = await db.query(_favTable);
    if (maps.isEmpty) {
      return [];
    } else {
      List<DataBaseModel> favproducts = [];
      for (final element in maps) {
        favproducts.add(DataBaseModel.fromMap(element));
      }
      return favproducts;
    }
  }

  Future<DataBaseModel> insert(DataBaseModel dataBaseModel) async {
    await db.insert(
      _favTable,
      dataBaseModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return dataBaseModel;
  }

  Future<int> delete(int id) async {
    return await db
        .delete(_favTable, where: '$columnid = ?', whereArgs: [id]);
  }

  Future close() async => db.close();
}
