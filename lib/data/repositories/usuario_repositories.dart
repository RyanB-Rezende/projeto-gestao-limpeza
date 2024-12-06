import 'package:app_estoque_limpeza/core/database_helper.dart';
import 'package:app_estoque_limpeza/data/model/usuario_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class UsuarioRepository {
  Future<void> insertUsuario(Usuario usuario) async {
    final db = await DatabaseHelper.initDb();
    await db.insert(
      'usuario',
      usuario.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Usuario>> getUsuarios() async {
    final db = await DatabaseHelper.initDb();
    final List<Map<String, Object?>> usuarioMaps = await db.query('usuario');
    return usuarioMaps.map((map) {
      return Usuario(
        idusuario: map['idusuario'] as int?,
        matricula: map['matricula'] as String,
        nome: map['nome'] as String,
        idtelefone: map['idtelefone'] as int,
        email: map['email'] as String,
        idperfil: map['idperfil'] as int,
      );
    }).toList();
  }

  Future<void> updateUsuario(Usuario usuario) async {
    final db = await DatabaseHelper.initDb();
    await db.update(
      'usuario',
      usuario.toMap(),
      where: 'idusuario = ?',
      whereArgs: [usuario.idusuario],
    );
  }

  Future<void> deleteUsuario(int id) async {
    final db = await DatabaseHelper.initDb();
    await db.delete(
      'usuario',
      where: 'idusuario = ?',
      whereArgs: [id],
    );
  }
}
