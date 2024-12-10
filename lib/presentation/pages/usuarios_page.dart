import 'dart:convert';

import 'package:app_estoque_limpeza/data/repositories/usuario_repositories.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:app_estoque_limpeza/data/model/usuario_model.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({super.key});

  @override
  UsuariosPageState createState() => UsuariosPageState();
}

class UsuariosPageState extends State<UsuariosPage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _matriculaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  final List<String> _perfis = ['Administrador', 'Usuário'];
  String? _perfilSelecionado;

  final _formKey = GlobalKey<FormState>();

  final UsuarioRepository _usuarioRepository = UsuarioRepository();

  Future<void> _cadastrarUsuario() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Criptografar a senha usando SHA-256
        final bytes =
            utf8.encode(_senhaController.text); // Converte a senha em bytes
        final senhaCriptografada =
            sha256.convert(bytes).toString(); // Gera o hash

        final novoUsuario = Usuario(
          idusuario: null,
          matricula: _matriculaController.text,
          nome: _nomeController.text,
          telefone: _telefoneController.text,
          email: _emailController.text,
          senha: senhaCriptografada, // Armazena a senha criptografada
          idperfil: _perfis.indexOf(_perfilSelecionado!) + 1,
        );

        // Inserir o usuário no banco de dados
        await _usuarioRepository.insertUsuario(novoUsuario);

        // Verificar se o widget ainda está montado
        if (!mounted) return;

        // Exibir mensagem de sucesso
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuário cadastrado com sucesso!')),
        );

        // Limpar os campos e resetar o formulário
        _nomeController.clear();
        _telefoneController.clear();
        _matriculaController.clear();
        _emailController.clear();
        _senhaController.clear();
        setState(() {
          _perfilSelecionado = null;
        });
      } catch (e) {
        // Verificar se o widget ainda está montado
        if (!mounted) return;

        // Exibir mensagem de erro
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao cadastrar usuário: $e')),
        );
      }
    } else {
      // Exibir mensagem de erro ao validar o formulário
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, corrija os erros no formulário!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
      filled: true,
      fillColor: Colors.blue[50],
      labelStyle: const TextStyle(color: Colors.black),
      hintStyle: const TextStyle(color: Colors.black54),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Usuário'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: inputDecoration.copyWith(labelText: 'Nome'),
                style: const TextStyle(color: Colors.black),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O nome é obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _telefoneController,
                decoration: inputDecoration.copyWith(labelText: 'Telefone'),
                keyboardType: TextInputType.phone,
                style: const TextStyle(color: Colors.black),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O telefone é obrigatório';
                  }
                  if (!RegExp(r'^\d+$').hasMatch(value)) {
                    return 'Digite apenas números';
                  }
                  if (value.length < 10 || value.length > 11) {
                    return 'Informe um telefone válido com 10 ou 11 dígitos';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _matriculaController,
                decoration: inputDecoration.copyWith(labelText: 'Matrícula'),
                style: const TextStyle(color: Colors.black),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'A matrícula é obrigatória';
                  }
                  if (value.length < 3) {
                    return 'A matrícula deve conter no mínimo 3 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _senhaController,
                obscureText: true,
                decoration: inputDecoration.copyWith(labelText: 'Senha'),
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.black),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'A senha é obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: inputDecoration.copyWith(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.black),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O email é obrigatório';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Informe um email válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: inputDecoration.copyWith(labelText: 'Perfil'),
                value: _perfilSelecionado,
                items: _perfis
                    .map((perfil) => DropdownMenuItem(
                          value: perfil,
                          child: Text(perfil),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _perfilSelecionado = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, selecione um perfil';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: _cadastrarUsuario,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Cadastrar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
