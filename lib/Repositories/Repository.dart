import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  String databaseName = 'gastitos.db';

  final String tableName = "";
  final String _idField = 'id';

  String get idField => _idField;

  final List<Field> tableFields = new List<Field>();

  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    // Get a location using path_provider
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, databaseName);

    //await deleteDatabase(path);
    var theDb = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        String fields = '';
        String comma = '';

        tableFields.forEach((Field field) {
          fields += '$comma${field.name} ${field.type}';
          comma = ', ';
        });
        String q = 'CREATE TABLE IF NOT EXISTS $tableName ($fields);';
        await db.execute(q);
      },
    );

    return theDb;
  }

  Future<List<Map<String, dynamic>>> select(
      {List<String> fields = const [], Where where}) async {
    var dbClient = await db;

    String queryFields = '';
    String comma = '';
    String conditions = _getConditions(where);

    if (fields.length > 0) {
      fields.forEach((String field) {
        queryFields += "$comma $field";
        comma = ',';
      });
    }
    else {
      queryFields = '*';
    }

    String q = 'SELECT $queryFields FROM $tableName where $conditions';

    List<Map<String, dynamic>> list = await dbClient.rawQuery(q);

    return list;
  }

  Future<void> save(Map<String, dynamic> data) async {
    var dbClient = await db;
    String q = '';

    String fields = '';
    String values = '';
    String comma = '';

    if (data[idField] == null) {
      data.forEach((field, value) {
        if (field != idField) {
          fields += "$comma $field";
          if (value is num) {
            values += "$comma $value";
          } else {
            values += "$comma '$value'";
          }
          comma = ',';
        }
      });
      q = "insert into $tableName($fields) values($values)";
    } else {
      data.forEach((field, value) {
        if (field != idField) {
          if (value is num) {
            values = "$values $comma $field = $value";
          } else {
            values = "$values $comma $field = '$value'";
          }
          comma = ',';
        }
      });
      q = "update $tableName set $values where $idField = ${data[idField]}";
    }
    print(q);
    dbClient.rawQuery(q);
  }

  Future<void> delete(Where where) async {
    var dbClient = await db;

    String conditions = _getConditions(where);

    String q = "delete from $tableName where $conditions";
    print(q);
    await dbClient.delete(tableName,where:conditions);
  }

  String _getConditions(Where where) {
    String conditions = '';

    if (where != null) {
      if (where.conditions.length > 0) {
        where.conditions.forEach((Condition condition) {
          conditions +=
              ' ${condition.conjunctiveOperator} ${condition.field} ${condition.value}';
        });
      }
    } 
    
    return conditions;
  }
}

class Field {
  String name;
  String type;

  Field(this.name, this.type);
}

class Where {
  List<Condition> conditions;

  Where(this.conditions);
}

class Condition {
  String conjunctiveOperator;
  String field;
  String value;

  Condition({this.field, this.value, this.conjunctiveOperator = ''});
}
