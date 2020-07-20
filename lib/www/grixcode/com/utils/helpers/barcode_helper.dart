import 'package:girixscanner/www/grixcode/com/models/barcode/barcode_provider_model.dart';
import 'package:girixscanner/www/grixcode/com/utils/database/tables.dart';
import 'package:sqflite/sqflite.dart';

class BarcodeHelper {
  static Future<BarcodeProvider> insertBarcode(
      Database db, BarcodeProvider providerModel) async {
    providerModel.id = await db.insert(
        BarcodeTable.tableName, providerModel.toSqlFliteMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return providerModel;
  }

  static Future<BarcodeProvider> getTodo(Database database, int id) async {
    List<Map> maps = await database.query(BarcodeTable.tableName,
        where: '${BarcodeTable.colId} = ?', whereArgs: [id]);
    if (maps.length > 0) {
      return BarcodeProvider.fromSqlFliteMap(maps.first);
    }
    return null;
  }

  static Future<List<BarcodeProvider>> fetchAll(Database database) async {
    List<Map> maps = await database.query(BarcodeTable.tableName);
    if (maps.length > 0) {
//      print("Barcodes From Database: $maps");
      return maps.map((e) => BarcodeProvider.fromSqlFliteMap(e)).toList();
    }
    return null;
  }

  static Future<int> delete(Database db, int id) async {
    return await db.delete(BarcodeTable.tableName,
        where: '${BarcodeTable.colId} = ?', whereArgs: [id]);
  }

  Future<int> update(Database db, BarcodeProvider providerModel) async {
    return await db.update(
        BarcodeTable.tableName, providerModel.toSqlFliteMap(),
        where: '${BarcodeTable.colId} = ?', whereArgs: [providerModel.id]);
  }
}
