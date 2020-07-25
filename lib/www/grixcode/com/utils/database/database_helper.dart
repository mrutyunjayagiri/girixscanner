import 'dart:async';
import 'dart:io';

import 'package:girixscanner/www/grixcode/com/models/barcode/barcode_provider_model.dart';
import 'package:girixscanner/www/grixcode/com/models/barcode/qr_code_provider.dart';
import 'package:girixscanner/www/grixcode/com/utils/database/tables.dart';
import 'package:girixscanner/www/grixcode/com/utils/helpers/barcode_helper.dart';
import 'package:girixscanner/www/grixcode/com/utils/helpers/qr_code_helper.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

/// delete the db, create the folder and returnes its path
Future<String> initDeleteDb(String dbName) async {
  final databasePath = await getDatabasesPath();
  // print(databasePath);
  final path = join(databasePath, dbName);

  // make sure the folder exists
  if (await Directory(dirname(path)).exists()) {
    await deleteDatabase(path);
  } else {
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (e) {
      print(e);
    }
  }
  return path;
}

class DatabaseHelper {
  static final String _databaseName = "GirixScanner.db";
  DatabaseHelper _instance;

  DatabaseHelper._private();

  Database _database;

  DatabaseHelper() {
    _instance = _instance ?? DatabaseHelper._private();
    print("Database ");
  }

  Future<Database> get database async => _database ?? await _initDatabase();

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);

    // For checking Version

    return await openDatabase(path, onCreate: _onCreate, version: 1);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
create table ${BarcodeTable.tableName} ( 
  ${BarcodeTable.colId} integer primary key autoincrement, 
  ${BarcodeTable.colBarcodeName} text not null,
  ${BarcodeTable.colFileName} text not null,
  ${BarcodeTable.colData} text not null,
  ${BarcodeTable.colQrType} text not null,
  ${BarcodeTable.colPath} text not null,
  ${BarcodeTable.colBarcodeType} text not null,
  ${BarcodeTable.colCreatedAt} text not null
  
  )
''');

    await db.execute('''
create table ${QrTable.tableName} ( 
  ${QrTable.colId} integer primary key autoincrement, 
  ${QrTable.colFileName} text not null,
  ${QrTable.colData} text not null,
  ${QrTable.colQrType} text not null,
  ${QrTable.colCreatedAt} text not null,
  ${QrTable.colQrVersion} integer not null
  
  )
''');
  }

  Future close() async {
    Database _database = await database;
    await _database.close();
  }

  /// Barcode Helper

  Future<BarcodeProvider> insertBarcode(BarcodeProvider providerModel) async {
    Database _db = await _instance.database;
    return BarcodeHelper.insertBarcode(_db, providerModel);
  }

  Future<List<BarcodeProvider>> fetchAllBarcode() async {
    Database _db = await _instance.database;
    return BarcodeHelper.fetchAll(_db);
  }

  Future<int> deleteBarcode(int id) async {
    Database _db = await _instance.database;
    return BarcodeHelper.delete(_db, id);
  }

  /// QrCode Helper
  Future<QrCodeProvider> insertQrcode(QrCodeProvider providerModel) async {
    Database _db = await _instance.database;
    return QrCodeHelper.insertQrCode(_db, providerModel);
  }

  Future<List<QrCodeProvider>> fetchAllQrcodes() async {
    Database _db = await _instance.database;
    return QrCodeHelper.fetchAll(_db);
  }

  Future<int> deleteQrcode(int id) async {
    Database _db = await _instance.database;
    return QrCodeHelper.delete(_db, id);
  }

  ///
}
