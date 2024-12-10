class Usuario {
  final int? idusuario;
  final String matricula;
  final String nome;
  final String telefone;
  final String email;
  final int idperfil;
  final String senha;

  Usuario({
    this.idusuario,
    required this.matricula,
    required this.nome,
    required this.telefone,
    required this.email,
    required this.idperfil,
    required this.senha,
  });

  Map<String, dynamic> toMap() {
    return {
      'idusuario': idusuario,
      'matricula': matricula,
      'nome': nome,
      'telefone': telefone,
      'email': email,
      'idperfil': idperfil,
      'senha': senha,
    };
  }
}
