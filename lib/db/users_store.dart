import 'package:sembast/sembast.dart';
import 'package:sembast_demo/db/db.dart';
import 'package:sembast_demo/models/user.dart';

class UsersStore {
  UsersStore._internal();
  static UsersStore _instance = UsersStore._internal();
  static UsersStore get instance => _instance;
  final Database _db = DB.instance.database;
  final StoreRef<String, Map> _store = StoreRef<String, Map>('users');

  Future<List<User>> find({Finder finder}) async {
    List<RecordSnapshot<String, Map>> snapshots =
        await this._store.find(this._db, finder: finder);
    return snapshots.map((RecordSnapshot<String, Map> snap) {
      //print("key: ${snap.key}");
      return User.fromJson(snap.value);
    }).toList();
  }

  Future<void> add(User user) async {
    await this._store.record(user.id).put(this._db, user.toJson());
  }

  Future<int> delete({Finder finder}) async {
    return await this._store.delete(this._db, finder: finder);
  }
}
