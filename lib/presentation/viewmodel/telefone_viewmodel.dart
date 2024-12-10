import 'package:app_estoque_limpeza/data/model/telefone_model.dart';
import 'package:app_estoque_limpeza/data/repositories/telefone_repositories.dart';

class TelefoneViewModel {
  final TelefoneRepository repository;

  TelefoneViewModel(this.repository);

  Future<void> addTelefone(Telefone telefone) async {
    await repository.insertTelefone(telefone);
  }

  Future<List<Telefone>> getTelefones() async {
    return await repository.getTelefones();
  }

  Future<void> updateTelefone(Telefone telefone) async {
    await repository.updateTelefone(telefone);
  }

  Future<void> deleteTelefone(int? id) async {
    await repository.deleteTelefone(id!);
  }
}
