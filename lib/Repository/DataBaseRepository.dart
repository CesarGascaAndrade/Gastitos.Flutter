import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart' as p;

class DataBaseRepository {
  late Database db;

  String tableName = '';

  String idField = 'id';

  Map<String, String> fields = {};

  DataBaseRepository() {
    this.tableName = this.getTableName();
  }

  openDb() async {
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'ExpirationDatabase.db');

    this.db = await openDatabase(
      path,
      version: 1,
    );
  }

  closeDb() async {
    await this.db.close();
  }

  createTable() async {
    String fields = '';
    String comma = '';

    this.fields.forEach((field, definition) {
      fields += '$comma$field $definition';

      comma = ', ';
    });

    await this.db.execute(
        'CREATE TABLE IF NOT EXISTS ${this.tableName.toLowerCase()} ($fields)');
  }

  String getTableName() {
    String table = (this).toString().replaceAll('Instance of ', '');
    table = table.replaceAll("'", '');
    table = table.replaceAll("Repository", '');

    return table;
  }

  Future<List<Map<String, Object>>> find({
    List fields = const [],
    Map<String, Object> where = const {},
    String order = '',
    List group = const [],
  }) async {
    await this.openDb();
    await this.createTable();

    String fields_string = '';
    String comma = '';

    if (fields.length > 0) {
      fields.forEach((element) {
        fields_string += comma + element;
        comma = ', ';
      });
    } else {
      fields_string = '*';
    }

    String select_query = 'select ${fields_string} from ${this.tableName}';

    if (where.length > 0) {
      select_query += ' where ';
      where.forEach((key, value) {
        select_query += '$key $value';
      });
    }

    if (order != '') {
      select_query += ' ORDER BY ' + order;
    }

    String group_string = ' GROUP BY ';
    comma = '';
    if (group.length > 0) {
      group.forEach((field) {
        group_string += comma + field;
        comma = ', ';
      });

      select_query += group_string;
    }

    //print(select_query);
    var result = await this.db.rawQuery(select_query);

    List<Map<String, Object>> _result = [];

    result.forEach((contenedor) {
      _result.add(contenedor.cast());
    });

    return _result;
  }

  Future<bool> save(Map<String, Object> object) async {
    await this.openDb();
    var id = object['id'];
    object.remove('id');

    if (id == 0) {
      this.db.insert(this.getTableName(), object);
    } else {
      this.db.update(
            this.getTableName(),
            {...object},
            where: '${this.idField} = $id',
          );
    }

    //await this.closeDb();
    return true;
  }

  Future<bool> delete(int id) async {
    await this.openDb();

    this.db.delete(
          this.getTableName(),
          where: '${this.idField} = $id',
        );

    return true;
  }
}
