import 'package:app_estoque_limpeza/core/database_helper.dart';
import 'package:app_estoque_limpeza/data/model/produto_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class ProdutoRepositories {
  Future<void> insertProduto(ProdutoModel produto) async {
    final db = await DatabaseHelper.initDb();
    await db.insert(
      'Produto',
      produto.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ProdutoModel>> getProduto() async {
    final db = await DatabaseHelper.initDb();
    final List<Map<String, Object?>> produtoMaps = await db.query('Produto');
    return produtoMaps.map((map) {
      return ProdutoModel(
          idMaterial: map['idproduto'] as int?,
          codigo: map['Codigo'] as String,
          nome: map['Nome'] as String,
          quantidade: map['Quantidade'] as int,
          validade: map['Validade'] as String?,
          local: map['Local'] as String,
          idtipo: map['idtipo'] as int,
          idfornecedor: map['idfornecedor'] as int,
          entrada: map['entrada'] as String);
    }).toList();
  }

  Future<void> updateProduto(ProdutoModel produto) async {
    final db = await DatabaseHelper.initDb();
    await db.update(
      'Produto',
      produto.toMap(),
      where: 'idMaterial = ?',
      whereArgs: [produto.idMaterial],
    );
  }

  Future<void> deleteProduto(int id) async {
    final db = await DatabaseHelper.initDb();
    await db.delete(
      'Produto',
      where: 'idMaterial = ?',
      whereArgs: [id],
    );
  }
}
