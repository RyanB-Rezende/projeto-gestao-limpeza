<<<<<<< HEAD
import 'package:app_estoque_limpeza/presentation/pages/homepage_admin.dart';
=======
import 'package:app_estoque_limpeza/presentation/pages/homepage_funcionario.dart';
>>>>>>> dg
import 'package:app_estoque_limpeza/presentation/pages/produto_page.dart';
import 'package:app_estoque_limpeza/presentation/pages/users/movimentacao_page.dart';
import 'package:app_estoque_limpeza/presentation/pages/usuarios_page.dart';
import 'package:app_estoque_limpeza/presentation/pages/users/login_page.dart';
import 'package:flutter/material.dart';
import 'presentation/pages/fornecedor_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Estoque Limpeza',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
<<<<<<< HEAD
      home: const HomePageAdmin(),
=======
      home: const HomePageFuncionario(),
>>>>>>> dg
      routes: {
        '/cadastroProduto': (context) =>
            const ProdutosPage(), // Adicione a página de cadastro de produto
        '/cadastroFornecedor': (context) => const FornecedorPage(),
        '/cadastrodeusuario': (context) =>
            const UsuariosPage(), // Adicione a página de cadastro de fornecedor
      },
    );
  }
}
