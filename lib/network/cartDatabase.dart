import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'dataBaseModel.dart';

const String _cartTable = 'CartTable';

class CartDataProvider {
  late Database db;
  static final CartDataProvider instance = CartDataProvider._internal();

  factory CartDataProvider() {
    return instance;
  }
  CartDataProvider._internal();

  Future open() async {
    db = await openDatabase(join(await getDatabasesPath(), 'cart.db'),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
create table $_cartTable ( 
  $columnid integer primary key,
  $columnname text ,
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
    List<Map<String, dynamic>> maps = await db.query(_cartTable);
    if (maps.isEmpty) {
      return [];
    } else {
      List<DataBaseModel> products = [];
      for (final element in maps) {
        products.add(DataBaseModel.fromMap(element));
      }
      return products;
    }
  }

  Future<DataBaseModel> insert(DataBaseModel dataBaseModel) async {
    await db.insert(
      _cartTable,
      dataBaseModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return dataBaseModel;
  }

  Future<int> delete(int id) async {
    return await db
        .delete(_cartTable, where: '$columnid = ?', whereArgs: [id]);
  }

  Future close() async => db.close();
}
