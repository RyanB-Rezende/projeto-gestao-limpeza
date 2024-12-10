import 'package:app_estoque_limpeza/data/model/tipo_model.dart';
import 'package:app_estoque_limpeza/data/repositories/tipo_repositories.dart';

class TipoViewModel {
  final TipoRepository repository;

  TipoViewModel(this.repository);

  Future<void> addTipo(Tipo tipo) async {
    await repository.insertTipo(tipo);
  }

  Future<List<Tipo>> getTipos() async {
    return await repository.getTipos();
  }

  Future<void> updateTipo(Tipo tipo) async {
    await repository.updateTipo(tipo);
  }

  Future<void> deleteTipo(int? id) async {
    await repository.deleteTipo(id!);
  }
}
