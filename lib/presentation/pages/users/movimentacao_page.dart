import 'package:app_estoque_limpeza/data/model/movimentacao_model.dart';
import 'package:flutter/material.dart';
import 'package:app_estoque_limpeza/data/model/produto_model.dart';
import 'package:app_estoque_limpeza/data/repositories/movimentacao_repositories.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart'; // Supondo que você tenha um repositório para movimentação.

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
      idproduto: widget.produto
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
      title: Text(
        'Detalhes do Produto: ${widget.produto.nome}',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      backgroundColor: Colors.blueAccent,
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Detalhes do produto em um Card estilizado
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Detalhes do Produto',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.blueGrey[800],
                      ),
                    ),
                    const Divider(),
                    Text('Código: ${widget.produto.codigo}'),
                    Text('Quantidade: ${widget.produto.quantidade}'),
                    Text('Data de Entrada: ${widget.produto.entrada}'),
                    if (widget.produto.validade != null)
                      Text('Validade: ${widget.produto.validade}'),
                    if (widget.produto.local.isNotEmpty)
                      Text('Local: ${widget.produto.local}'),
                    Text('Tipo: ${widget.produto.idtipo}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Formulário para registrar movimentação
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Registrar Movimentação',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.blueGrey,
                      ),
                    ),
                    const Divider(),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _entradaController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Quantidade de Entrada',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: Colors.blue[50],
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _saidaController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Quantidade de Saída',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: Colors.blue[50],
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _dataController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        MaskedInputFormatter('##/##/####'), // Define o formato da máscara
                      ],
                      decoration: InputDecoration(
                        labelText: 'Data (DD/MM/YYYY)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: Colors.blue[50],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: _registrarMovimentacao,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                        ),
                        child: const Text(
                          'Registrar Movimentação',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}
