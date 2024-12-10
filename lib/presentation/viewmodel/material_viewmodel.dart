import 'package:app_estoque_limpeza/data/repositories/material_repositories.dart';
import 'package:flutter/material.dart';
import 'package:app_estoque_limpeza/data/model/material_model.dart'
    as app_model;

class MaterialViewModel extends ChangeNotifier {
  final MaterialRepository _repository = MaterialRepository();

  List<app_model.Material> _materiais = [];
  List<app_model.Material> get materiais => _materiais;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchMateriais() async {
    _isLoading = true;
    notifyListeners();

    try {
      _materiais = await _repository.getMateriais();
      _errorMessage = null;
    } catch (error) {
      _errorMessage = 'Erro ao buscar materiais: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addMaterial(app_model.Material material) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _repository.insertMaterial(material);
      _materiais.add(material);
      _errorMessage = null;
    } catch (error) {
      _errorMessage = 'Erro ao adicionar material: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateMaterial(app_model.Material material) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _repository.updateMaterial(material);
      final index =
          _materiais.indexWhere((m) => m.idMaterial == material.idMaterial);
      if (index != -1) {
        _materiais[index] = material;
      }
      _errorMessage = null;
    } catch (error) {
      _errorMessage = 'Erro ao atualizar material: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteMaterial(int id) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _repository.deleteMaterial(id);
      _materiais.removeWhere((m) => m.idMaterial == id);
      _errorMessage = null;
    } catch (error) {
      _errorMessage = 'Erro ao excluir material: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
