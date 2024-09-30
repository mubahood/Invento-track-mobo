import 'package:flutter/material.dart';
import 'package:flutter_ui/model/ResponseModel.dart';
import 'package:flutter_ui/model/Utils.dart';
import 'package:sqflite/sqflite.dart';

class BudgetProgramModel {
  static String end_point = "BudgetProgram";
  static String tableName = "budget_programs";

  int id = 0;
  String created_at = "";
  String updated_at = "";
  String company_id = "";
  String company_text = "";
  String name = "";
  String total_collected = "";
  String total_expected = "";
  String total_in_pledge = "";
  String budget_total = "";
  String budget_spent = "";
  String budget_balance = "";
  String status = "";
  String deadline = "";
  String rsvp = "";
  String logo = "";
  String is_default = "";
  String is_active = "";
  String groups = "";
  String title = "";
  String bottom = "";

  static Future<List<BudgetProgramModel>> get_items({String where = ""}) async {
    List<BudgetProgramModel> items = await get_local_items();
    if (items.isEmpty) {
      await get_online_items();
      items = await get_local_items();
    } else {
      get_online_items();
    }
    return items;
  }

  static Future<List<BudgetProgramModel>> get_local_items({
    String where = " 1 ",
  }) async {
    List<BudgetProgramModel> data = [];
    Database db = await Utils.getDb();
    if (!db.isOpen) {
      Utils.toast('Failed to open database.', c: Colors.red);
      return data;
    }

    String table_resp = await initTable(db);
    if (!table_resp.isEmpty) {
      Utils.toast('Failed to init table budget_programs. $table_resp',
          c: Colors.red);
      return data;
    }

    List<Map> maps =
        await db.query(tableName, where: where, orderBy: ' id DESC ');

    if (maps.isEmpty) {
      return data;
    }
    List.generate(maps.length, (i) {
      data.add(BudgetProgramModel.fromJson(maps[i]));
    });
    return data;
  }

  static fromJson(dynamic m) {
    BudgetProgramModel item = BudgetProgramModel();
    if (m == null) {
      return item;
    }
    item.id = Utils.int_parse(m['id']);
    item.created_at = Utils.to_str(m['created_at']);
    item.updated_at = Utils.to_str(m['updated_at']);
    item.company_id = Utils.to_str(m['company_id']);
    item.company_text = Utils.to_str(m['company_text']);
    item.name = Utils.to_str(m['name']);
    item.total_collected = Utils.to_str(m['total_collected']);
    item.total_expected = Utils.to_str(m['total_expected']);
    item.total_in_pledge = Utils.to_str(m['total_in_pledge']);
    item.budget_total = Utils.to_str(m['budget_total']);
    item.budget_spent = Utils.to_str(m['budget_spent']);
    item.budget_balance = Utils.to_str(m['budget_balance']);
    item.status = Utils.to_str(m['status']);
    item.deadline = Utils.to_str(m['deadline']);
    item.rsvp = Utils.to_str(m['rsvp']);
    item.logo = Utils.to_str(m['logo']);
    item.is_default = Utils.to_str(m['is_default']);
    item.is_active = Utils.to_str(m['is_active']);
    item.groups = Utils.to_str(m['groups']);
    item.title = Utils.to_str(m['title']);
    item.bottom = Utils.to_str(m['bottom']);

    return item;
  }

  static Future<void> get_online_items() async {
    if (!(await Utils.isConnected())) {
      return;
    }
    ResponseModel? resp = null;
    try {
      resp = ResponseModel(await Utils.http_get('api/$end_point', {}));
    } catch (e) {
      resp = null;
    }
    if (resp == null) {
      print("FAILED TO FETCH DATA");
      return;
    }

    if (resp.code != 1) {
      Utils.toast(
        "Failed to fetch $tableName data. ${resp.message}",
        c: Colors.red,
      );
      return;
    }

    try {
      await delete_all();
    } catch (e) {
      Utils.toast("Failed to delete all $tableName data. ${e.toString()}",
          c: Colors.red);
    }

    if (!(resp.data.runtimeType.toString().toLowerCase().contains('list'))) {
      Utils.toast("Failed to fetch $tableName data. ${resp.data}",
          c: Colors.red);
      return;
    }

    //database db
    Database db = await Utils.getDb();
    //init table
    String tamp_resp = await initTable(db);

    if (!tamp_resp.isEmpty) {
      Utils.toast("Failed to init table $tableName. $tamp_resp", c: Colors.red);
      return;
    }
    await db.transaction((transaction) async {
      var batch = transaction.batch();
      for (var x in resp?.data) {
        BudgetProgramModel item = BudgetProgramModel.fromJson(x);
        try {
          batch.insert(tableName, item.toJson(),
              conflictAlgorithm: ConflictAlgorithm.replace);
        } catch (e) {
          Utils.toast("Failed to save $tableName data. ${e.toString()}",
              c: Colors.red);
        }
      }
      try {
        await batch.commit(continueOnError: true);
      } catch (e) {
        Utils.toast("Failed to commit $tableName data. ${e.toString()}",
            c: Colors.red);
      }
    });
  }

  static Future<String> delete_all() async {
    Database db = await Utils.getDb();
    if (!db.isOpen) {
      return 'Failed to open database.';
    }
    try {
      await db.delete(tableName);
      return '';
    } catch (e) {
      return 'Failed to delete table because ${e.toString()}.';
    }
  }

  Future<String> delete() async {
    Database db = await Utils.getDb();
    if (!db.isOpen) {
      return 'Failed to open database.';
    }
    try {
      await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
      return '';
    } catch (e) {
      return 'Failed to delete item because ${e.toString()}.';
    }
  }

  static Future<String> delete_item(int id) async {
    Database db = await Utils.getDb();
    if (!db.isOpen) {
      return 'Failed to open database.';
    }
    try {
      await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
      return '';
    } catch (e) {
      return 'Failed to delete item because ${e.toString()}.';
    }
  }

  Future<String> save() async {
    Database db = await Utils.getDb();
    String table_results = await initTable(db);
    if (table_results.isNotEmpty) {
      return table_results;
    }
    try {
      await db.insert(tableName, toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      return "";
    } catch (e) {
      return 'Failed to save item because ${e.toString()}.';
    }
    return "";
  }

  static Future<String> initTable(Database db) async {
    if (!db.isOpen) {
      Utils.toast('Failed to open database.', c: Colors.red);
      return 'Failed to open database.';
    }
    String sql = 'CREATE TABLE IF NOT EXISTS ${tableName} ('
        "id INTEGER PRIMARY KEY"
        ",created_at TEXT"
        ",updated_at TEXT"
        ",company_id TEXT"
        ",company_text TEXT"
        ",name TEXT"
        ",total_collected TEXT"
        ",total_expected TEXT"
        ",total_in_pledge TEXT"
        ",budget_total TEXT"
        ",budget_spent TEXT"
        ",budget_balance TEXT"
        ",status TEXT"
        ",deadline TEXT"
        ",rsvp TEXT"
        ",logo TEXT"
        ",is_default TEXT"
        ",is_active TEXT"
        ",groups TEXT"
        ",title TEXT"
        ",bottom TEXT"
        ')';
    try {
      await db.execute(sql);
      return "";
    } catch (e) {
      return 'Failed to create table because ${e.toString()}.';
    }
  }

  toJson() {
    return {
      'id': id,
      'created_at': created_at,
      'updated_at': updated_at,
      'company_id': company_id,
      'company_text': company_text,
      'name': name,
      'total_collected': total_collected,
      'total_expected': total_expected,
      'total_in_pledge': total_in_pledge,
      'budget_total': budget_total,
      'budget_spent': budget_spent,
      'budget_balance': budget_balance,
      'status': status,
      'deadline': deadline,
      'rsvp': rsvp,
      'logo': logo,
      'is_default': is_default,
      'is_active': is_active,
      'groups': groups,
      'title': title,
      'bottom': bottom,
    };
  }
}
