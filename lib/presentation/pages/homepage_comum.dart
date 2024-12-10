import 'package:flutter/material.dart';

class HomepageComum extends StatefulWidget {
  const HomepageComum({super.key});

  @override
  State<HomepageComum> createState() => _HomepageComumState();
}

class _HomepageComumState extends State<HomepageComum> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página do Usuário'),
      ),
      body: const Center(
        child: Text('Página do usuário comum'),
      ),
    );
  }
}
