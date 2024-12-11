import 'package:app_estoque_limpeza/data/model/movimentacao_model.dart';
import 'package:flutter/material.dart';
import 'package:app_estoque_limpeza/data/model/produto_model.dart';
import 'package:app_estoque_limpeza/data/repositories/movimentacao_repositories.dart'; // Supondo que você tenha um repositório para movimentação.

class ProdutoDetalhesPage extends StatefulWidget {
  final ProdutoModel produto;

  const ProdutoDetalhesPage({Key? key, required this.produto})
      : super(key: key);

  @override
  _ProdutoDetalhesPageState createState() => _ProdutoDetalhesPageState();
}

class _ProdutoDetalhesPageState extends State<ProdutoDetalhesPage> {
  final TextEditingController _entradaController = TextEditingController();
  final TextEditingController _saidaController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();

  final MovimentacaoRepository _movimentacaoRepository =
      MovimentacaoRepository();

  @override
  void dispose() {
    _entradaController.dispose();
    _saidaController.dispose();
    _dataController.dispose();
    super.dispose();
  }

  // Função para salvar a movimentação
  _registrarMovimentacao() async {
    final int entrada = int.tryParse(_entradaController.text) ?? 0;
    final int saida = int.tryParse(_saidaController.text) ?? 0;
    final String data = _dataController.text;

    if (entrada == 0 && saida == 0) {
      _showDialog('Erro', 'Informe a quantidade de entrada ou saída.');
      return;
    }

    if (data.isEmpty) {
      _showDialog('Erro', 'Informe a data.');
      return;
    }

    final movimentacao = Movimentacao(
      entrada: entrada.toString(),
      saida: saida.toString(),
      idmaterial: widget.produto
          .idMaterial!, // Supondo que o campo id no ProdutoModel seja id
      idusuario:
          1, // Aqui você deve pegar o ID do usuário logado (exemplo, 1 é fixo para teste)
    );

    // Salvar movimentação no banco
    await _movimentacaoRepository.insertMovimentacao(movimentacao);

    _showDialog('Sucesso', 'Movimentação registrada com sucesso.');
  }

  // Função para exibir mensagens no AlertDialog
  _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Produto: ${widget.produto.nome}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Exibindo detalhes do produto
              Text('Código: ${widget.produto.codigo}'),
              Text('Quantidade: ${widget.produto.quantidade}'),
              Text('Data de Entrada: ${widget.produto.entrada}'),
              if (widget.produto.validade != null)
                Text('Validade: ${widget.produto.validade}'),
              if (widget.produto.local.isNotEmpty)
                Text('Local: ${widget.produto.local}'),
              Text('Tipo: ${widget.produto.idtipo}'),
              const SizedBox(height: 20),

              // Formulário para entrada e saída
              const Text(
                'Registrar Movimentação',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _entradaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Quantidade de Entrada',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _saidaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Quantidade de Saída',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _dataController,
                decoration: const InputDecoration(
                  labelText: 'Data (dd/MM/yyyy)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registrarMovimentacao,
                child: const Text('Registrar Movimentação'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
