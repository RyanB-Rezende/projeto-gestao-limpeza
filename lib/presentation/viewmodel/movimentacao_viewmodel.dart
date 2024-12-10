import 'package:app_estoque_limpeza/data/model/movimentacao_model.dart';
import 'package:app_estoque_limpeza/data/repositories/movimentacao_repositories.dart';

class MovimentacaoViewModel {
  final MovimentacaoRepository repository;

  MovimentacaoViewModel(this.repository);

  Future<void> addMovimentacao(Movimentacao movimentacao) async {
    await repository.insertMovimentacao(movimentacao);
  }

  Future<List<Movimentacao>> getMovimentacoes() async {
    return await repository.getMovimentacoes();
  }

  Future<void> updateMovimentacao(Movimentacao movimentacao) async {
    await repository.updateMovimentacao(movimentacao);
  }

  Future<void> deleteMovimentacao(int? id) async {
    await repository.deleteMovimentacao(id!);
  }
}
