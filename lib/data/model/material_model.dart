class Material {
  final int? idMaterial;
  final String codigo;
  final String nome;
  final double quantidade;
  final String validade;
  final String local;
  final int idtipo;
  final int idfornecedor;
  final String entrada;

  Material({
    this.idMaterial,
    required this.codigo,
    required this.nome,
    required this.quantidade,
    required this.validade,
    required this.local,
    required this.idtipo,
    required this.idfornecedor,
    required this.entrada,
  });

  Map<String, dynamic> toMap() {
    return {
      'idMaterial': idMaterial,
      'Codigo': codigo,
      'Nome': nome,
      'Quantidade': quantidade,
      'Validade': validade,
      'Local': local,
      'idtipo': idtipo,
      'idfornecedor': idfornecedor,
      'entrada': entrada,
    };
  }
}
