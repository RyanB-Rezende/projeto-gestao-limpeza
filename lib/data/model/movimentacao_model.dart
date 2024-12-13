class Movimentacao {
  final int? idmovimentacao;
  final String entrada;
  final String saida;
  final int idproduto;
  final int idusuario;

  Movimentacao({
    this.idmovimentacao,
    required this.entrada,
    required this.saida,
    required this.idproduto,
    required this.idusuario,
  });

  Map<String, dynamic> toMap() {
    return {
      'idmovimentacao': idmovimentacao,
      'entrada': entrada,
      'saida': saida,
      'idmaterial': idproduto,
      'idusuario': idusuario,
    };
  }
}
