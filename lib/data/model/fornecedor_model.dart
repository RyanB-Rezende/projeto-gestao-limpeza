class Fornecedor {
  final int? idfornecedor;
  final String nome;
  final String endereco;
  final String telefone;

  Fornecedor(
      {this.idfornecedor,
      required this.nome,
      required this.endereco,
      required this.telefone});

  Map<String, dynamic> toMap() {
    return {
      'idfornecedor': idfornecedor,
      'nome': nome,
      'endereco': endereco,
      'telefone': telefone,
    };
  }
}
