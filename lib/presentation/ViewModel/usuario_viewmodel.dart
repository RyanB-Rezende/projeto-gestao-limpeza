import 'package:app_estoque_limpeza/data/repositories/usuario_repositories.dart';
import 'package:flutter/material.dart';
import 'package:app_estoque_limpeza/data/model/usuario_model.dart';

class UsuarioViewModel extends ChangeNotifier {
  final UsuarioRepository _repository = UsuarioRepository();

  List<Usuario> _usuarios = [];
  List<Usuario> get usuarios => _usuarios;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchUsuarios() async {
    _isLoading = true;
    notifyListeners();

    try {
      _usuarios = await _repository.getUsuarios();
      _errorMessage = null;
    } catch (error) {
      _errorMessage = 'Erro ao buscar usuários: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addUsuario(Usuario usuario) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _repository.insertUsuario(usuario);
      _usuarios.add(usuario);
      _errorMessage = null;
    } catch (error) {
      _errorMessage = 'Erro ao adicionar usuário: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateUsuario(Usuario usuario) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _repository.updateUsuario(usuario);
      final index =
          _usuarios.indexWhere((u) => u.idusuario == usuario.idusuario);
      if (index != -1) {
        _usuarios[index] = usuario;
      }
      _errorMessage = null;
    } catch (error) {
      _errorMessage = 'Erro ao atualizar usuário: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteUsuario(int id) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _repository.deleteUsuario(id);
      _usuarios.removeWhere((u) => u.idusuario == id);
      _errorMessage = null;
    } catch (error) {
      _errorMessage = 'Erro ao excluir usuário: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
