class Tipo {
  final int? idtipo;
  final String tipo;

  Tipo({this.idtipo, required this.tipo});

  Map<String, dynamic> toMap() {
    return {
      'idtipo': idtipo,
      'tipo': tipo,
    };
  }
}
