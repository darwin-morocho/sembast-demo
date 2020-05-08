import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast_demo/db/db.dart';

class MyAppTheme extends ChangeNotifier {
  MyAppTheme._internal();
  static MyAppTheme _instance = MyAppTheme._internal();
  static MyAppTheme get instance => _instance;

  final StoreRef _store = StoreRef.main();
  final Database _db = DB.instance.database;

  bool _darkEnabled = false;

  bool get darkEnabled => _darkEnabled;

  Future<void> init() async {
    this._darkEnabled =
        (await this._store.record('DARK_ENABLED').get(this._db)) ?? false;
  }

  change(bool darkEnabled) async {
    this._darkEnabled = darkEnabled;
    final dataSaved = await this
        ._store
        .record('DARK_ENABLED')
        .put(this._db, this._darkEnabled);
    print("theme darkEnabled: $dataSaved");
    notifyListeners();
  }
}
