import 'package:app_estoque_limpeza/data/repositories/fornecedor_repository.dart';
import 'package:flutter/material.dart';
import 'package:app_estoque_limpeza/data/model/fornecedor_model.dart';

class FornecedorViewModel extends ChangeNotifier {
  final FornecedorRepository _repository = FornecedorRepository();

  List<Fornecedor> _fornecedores = [];
  List<Fornecedor> get fornecedores => _fornecedores;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Fetch fornecedores
  Future<void> fetchFornecedores() async {
    _setLoading(true);
    try {
      _fornecedores = await _repository.getFornecedores();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Erro ao carregar fornecedores: $e';
    } finally {
      _setLoading(false);
    }
  }

  // Add fornecedor
  Future<void> addFornecedor(Fornecedor fornecedor) async {
    _setLoading(true);
    try {
      await _repository.insertFornecedor(fornecedor);
      await fetchFornecedores(); // Atualizar a lista
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Erro ao adicionar fornecedor: $e';
    } finally {
      _setLoading(false);
    }
  }

  // Update fornecedor
  Future<void> updateFornecedor(Fornecedor fornecedor) async {
    _setLoading(true);
    try {
      await _repository.updateFornecedor(fornecedor);
      await fetchFornecedores(); // Atualizar a lista
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Erro ao atualizar fornecedor: $e';
    } finally {
      _setLoading(false);
    }
  }

  // Delete fornecedor
  Future<void> deleteFornecedor(int id) async {
    _setLoading(true);
    try {
      await _repository.deleteFornecedor(id);
      await fetchFornecedores(); // Atualizar a lista
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Erro ao deletar fornecedor: $e';
    } finally {
      _setLoading(false);
    }
  }

  // Helper para gerenciar estado de carregamento
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
