import 'package:girixscanner/www/grixcode/com/models/barcode/qr_code_provider.dart';
import 'package:girixscanner/www/grixcode/com/utils/database/tables.dart';
import 'package:sqflite/sqflite.dart';

class QrCodeHelper {
  static Future<QrCodeProvider> insertQrCode(
      Database db, QrCodeProvider providerModel) async {
    providerModel.id = await db.insert(
        QrTable.tableName, providerModel.toSqlFliteMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return providerModel;
  }

  static Future<QrCodeProvider> getTodo(Database database, int id) async {
    List<Map> maps = await database.query(QrTable.tableName,
        where: '${QrTable.colId} = ?', whereArgs: [id]);
    if (maps.length > 0) {
      return QrCodeProvider.fromSqlFliteMap(maps.first);
    }
    return null;
  }

  static Future<List<QrCodeProvider>> fetchAll(Database database) async {
    List<Map> maps = await database.query(QrTable.tableName);
    if (maps.length > 0) {
//      print("Barcodes From Database: $maps");
      return maps.map((e) => QrCodeProvider.fromSqlFliteMap(e)).toList();
    }
    return null;
  }

  static Future<int> delete(Database db, int id) async {
    return await db.delete(QrTable.tableName,
        where: '${QrTable.colId} = ?', whereArgs: [id]);
  }

  Future<int> update(Database db, QrCodeProvider providerModel) async {
    return await db.update(QrTable.tableName, providerModel.toSqlFliteMap(),
        where: '${QrTable.colId} = ?', whereArgs: [providerModel.id]);
  }
}
