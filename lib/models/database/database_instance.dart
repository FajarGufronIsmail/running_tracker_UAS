import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:running_tracker_berlari/models/lari_detail_model.dart';
import 'package:running_tracker_berlari/models/lari_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class DatabaseInstance {
  final String _databaseName = 'berlari.db';
  final int _databaseVersion = 1;

  //tabel lari
  final String lariTableName = "lari";
  final String id_lari = "id";
  final String mulai = "mulai";
  final String selesai = "selesai";

  //tabel lari detail
  final String lariDetailTableName = "lari_detail";
  final String id_lari_detail = "id";
  final String lari_id = "lari_id";
  final String latitude = "latitude";
  final String longitude = "longitude";
  final String waktu = "waktu";

  Database? _database;

  Future<Database> database() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databaseName);
    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $lariTableName ($id_lari INTEGER PRIMARY KEY, $mulai TEXT, $selesai TEXT)');

    await db.execute(
        'CREATE TABLE $lariDetailTableName ($id_lari_detail INTEGER PRIMARY KEY, $lari_id INTEGER, $latitude DOUBLE, $longitude DOUBLE, $waktu DATETIME)');
  }

  Future<List<BerlariModel>> getAllLari() async {
    final data = await _database!.query(lariTableName);
    List<BerlariModel> result =
        data.map((e) => BerlariModel.fromJson(e)).toList();

    return result;
  }

  Future<int> insertLari(Map<String, dynamic> row) async {
    final query = await _database!.insert(lariTableName, row);
    return query;
  }

  Future<int> insertLariDetail(Map<String, dynamic> row) async {
    final query = await _database!.insert(lariDetailTableName, row);
    return query;
  }

  Future<List<MapLatLng>> getDetailLari(int lariId) async {
    final data = await _database!.rawQuery(
        "SELECT * FROM ${lariDetailTableName} WHERE lari_id = $lariId");

    List<BerlariDetailModel> result =
        data.map((e) => BerlariDetailModel.fromJson(e)).toList();

    List<MapLatLng> arrayMapLatLng = [];

    result.forEach((element) {
      arrayMapLatLng.add(MapLatLng(element.latitude, element.longitude));
    });
    return arrayMapLatLng;
  }

  Future<int> updateLari(int lariId, Map<String, dynamic> row) async {
    final query = await _database!
        .update(lariTableName, row, where: '$id_lari = ?', whereArgs: [lariId]);

    return query;
  }
}
