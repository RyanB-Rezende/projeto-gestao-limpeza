import 'package:app_estoque_limpeza/data/repositories/usuario_repositories.dart';
import 'package:app_estoque_limpeza/data/model/usuario_model.dart';

class UsuarioViewModel {
  final UsuarioRepository repository;

  UsuarioViewModel(this.repository);

  List<Usuario> _usuarios = [];
  List<Usuario> get usuarios => _usuarios;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchUsuarios() async {
    _isLoading = true;

    try {
      _usuarios = await repository.getUsuarios();
      _errorMessage = null;
    } catch (error) {
      _errorMessage = 'Erro ao buscar usuários: $error';
    } finally {
      _isLoading = false;
    }
  }

  Future<void> addUsuario(Usuario usuario) async {
    _isLoading = true;

    try {
      await repository.insertUsuario(usuario);
      _usuarios.add(usuario);
      _errorMessage = null;
    } catch (error) {
      _errorMessage = 'Erro ao adicionar usuário: $error';
    } finally {
      _isLoading = false;
    }
  }

  Future<void> updateUsuario(Usuario usuario) async {
    _isLoading = true;

    try {
      await repository.updateUsuario(usuario);
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
    }
  }

  Future<void> deleteUsuario(int id) async {
    _isLoading = true;

    try {
      await repository.deleteUsuario(id);
      _usuarios.removeWhere((u) => u.idusuario == id);
      _errorMessage = null;
    } catch (error) {
      _errorMessage = 'Erro ao excluir usuário: $error';
    } finally {
      _isLoading = false;
    }
  }

  // Retorna o objeto Usuario autenticado ou null caso inválido
  Future<Usuario?> loginUser(String username, String password) async {
    return await repository.verifyLogin(username, password);
  }
}
