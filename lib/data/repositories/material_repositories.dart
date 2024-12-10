import 'package:app_estoque_limpeza/core/database_helper.dart';
import 'package:app_estoque_limpeza/data/model/material_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class MaterialRepository {
  Future<void> insertMaterial(Material material) async {
    final db = await DatabaseHelper.initDb();
    await db.insert(
      'Material',
      material.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Material>> getMateriais() async {
    final db = await DatabaseHelper.initDb();
    final List<Map<String, Object?>> materialMaps = await db.query('Material');
    return materialMaps.map((map) {
      return Material(
        idMaterial: map['idMaterial'] as int?,
        codigo: map['Codigo'] as String,
        nome: map['Nome'] as String,
        quantidade: map['Quantidade'] as double,
        validade: map['Validade'] as String,
        local: map['Local'] as String,
        idtipo: map['idtipo'] as int,
        idfornecedor: map['idfornecedor'] as int,
        entrada: map['entrada'] as String,
      );
    }).toList();
  }

  Future<void> updateMaterial(Material material) async {
    final db = await DatabaseHelper.initDb();
    await db.update(
      'Material',
      material.toMap(),
      where: 'idMaterial = ?',
      whereArgs: [material.idMaterial],
    );
  }

  Future<void> deleteMaterial(int id) async {
    final db = await DatabaseHelper.initDb();
    await db.delete(
      'Material',
      where: 'idMaterial = ?',
      whereArgs: [id],
    );
  }
}
