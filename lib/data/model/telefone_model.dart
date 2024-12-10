class Telefone {
  final int? idtelefone;
  final double telefone;

  Telefone({this.idtelefone, required this.telefone});

  Map<String, dynamic> toMap() {
    return {
      'idtelefone': idtelefone,
      'telefone': telefone,
    };
  }
}
