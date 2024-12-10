import 'package:app_estoque_limpeza/core/database_helper.dart';
import 'package:app_estoque_limpeza/data/model/telefone_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class TelefoneRepository {
  Future<void> insertTelefone(Telefone telefone) async {
    final db = await DatabaseHelper.initDb();
    await db.insert(
      'telefone',
      telefone.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Telefone>> getTelefones() async {
    final db = await DatabaseHelper.initDb();
    final List<Map<String, Object?>> telefoneMaps = await db.query('telefone');
    return telefoneMaps.map((map) {
      return Telefone(
        idtelefone: map['idtelefone'] as int?,
        telefone: map['telefone'] as double,
      );
    }).toList();
  }

  Future<void> updateTelefone(Telefone telefone) async {
    final db = await DatabaseHelper.initDb();
    await db.update(
      'telefone',
      telefone.toMap(),
      where: 'idtelefone = ?',
      whereArgs: [telefone.idtelefone],
    );
  }

  Future<void> deleteTelefone(int id) async {
    final db = await DatabaseHelper.initDb();
    await db.delete(
      'telefone',
      where: 'idtelefone = ?',
      whereArgs: [id],
    );
  }
}
