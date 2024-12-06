class Usuario {
  final int? idusuario;
  final String matricula;
  final String nome;
  final int idtelefone;
  final String email;
  final int idperfil;

  Usuario({
    this.idusuario,
    required this.matricula,
    required this.nome,
    required this.idtelefone,
    required this.email,
    required this.idperfil,
  });

  Map<String, dynamic> toMap() {
    return {
      'idusuario': idusuario,
      'matricula': matricula,
      'nome': nome,
      'idtelefone': idtelefone,
      'email': email,
      'idperfil': idperfil,
    };
  }
}
