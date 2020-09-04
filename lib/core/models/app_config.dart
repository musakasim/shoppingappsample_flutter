import 'package:shoppingappsampleflutter/core/models/db_model.dart';
import 'package:shoppingappsampleflutter/core/services/db.service.dart';
import 'package:shoppingappsampleflutter/service_locator.dart';

class AppConfig extends DbModel {
  DbService _database = locator<DbService>();
  String tableName = "appconfig";

  final int id;
  final String key;
  final String value;

  AppConfig({this.id, this.key, this.value});

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'key': key,
      'value': value,
    };
  }

  Future<AppConfig> getById(int id) async {
    // Query the table for all The Ts.
    final List<Map<String, dynamic>> maps =
        await _database.getAllTable(tableName);

    // Convert the List<Map<String, dynamic> into a List<T>.
    var list = List.generate(maps.length, (i) {
      return AppConfig(
        id: maps[i]['id'],
        key: maps[i]['key'],
        value: maps[i]['value'],
      );
    });

    return list.firstWhere((element) => element.id == id, orElse: () => null);
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'AppConfig{id: $id, key: $key, value: $value}';
  }
}
