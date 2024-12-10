import 'dart:convert';
import 'package:app_estoque_limpeza/core/database_helper.dart';
import 'package:app_estoque_limpeza/data/model/usuario_model.dart';
import 'package:crypto/crypto.dart';
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
        telefone: map['telefone'] as String,
        email: map['email'] as String,
        idperfil: map['idperfil'] as int,
        senha: map['senha'] as String,
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

  // Retorna o objeto Usuario se as credenciais forem válidas, ou null caso contrário
  Future<Usuario?> verifyLogin(String matricula, String password) async {
    final db = await DatabaseHelper.initDb();
    final encryptedPassword = sha256.convert(utf8.encode(password)).toString();
    final result = await db.query(
      'usuario',
      where: 'matricula = ? AND senha = ?',
      whereArgs: [matricula, encryptedPassword],
    );

    if (result.isNotEmpty) {
      return Usuario(
        idusuario: result.first['idusuario'] as int?,
        matricula: result.first['matricula'] as String,
        nome: result.first['nome'] as String,
        telefone: result.first['telefone'] as String,
        email: result.first['email'] as String,
        idperfil: result.first['idperfil'] as int,
        senha: result.first['senha'] as String,
      );
    }
    return null;
  }
}
