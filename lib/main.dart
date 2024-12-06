import 'package:app_estoque_limpeza/presentation/pages/fornecedor_page.dart';
import 'package:app_estoque_limpeza/presentation/pages/produto_page.dart';
import 'package:app_estoque_limpeza/presentation/pages/usuarios_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProdutosPage(), // MaterialPage como home
    );
  }
}
