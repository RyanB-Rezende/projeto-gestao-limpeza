import 'package:app_estoque_limpeza/data/model/produto_model.dart';
import 'package:app_estoque_limpeza/data/repositories/produto_repositories.dart';
import 'package:flutter/material.dart';

class ProdutoViewModel extends ChangeNotifier {
  final ProdutoRepositories _repository = ProdutoRepositories();

  List<ProdutoModel> _produto = [];
  List<ProdutoModel> get produto => _produto;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchProduto() async {
    _isLoading = true;
    notifyListeners();

    try {
      _produto = await _repository.getProduto();
      _errorMessage = null;
    } catch (error) {
      _errorMessage = 'Erro ao buscar materiais: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addProduto(ProdutoModel produto) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _repository.insertProduto(produto);
      _produto.add(produto);
      _errorMessage = null;
    } catch (error) {
      _errorMessage = 'Erro ao adicionar material: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProduto(ProdutoModel produto) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _repository.updateProduto(produto);
      final index =
          _produto.indexWhere((m) => m.idMaterial == produto.idMaterial);
      if (index != -1) {
        _produto[index] = produto;
      }
      _errorMessage = null;
    } catch (error) {
      _errorMessage = 'Erro ao atualizar material: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteProduto(int id) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _repository.deleteProduto(id);
      _produto.removeWhere((m) => m.idMaterial == id);
      _errorMessage = null;
    } catch (error) {
      _errorMessage = 'Erro ao excluir material: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
