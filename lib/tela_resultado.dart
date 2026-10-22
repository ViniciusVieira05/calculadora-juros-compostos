import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'calculo.dart';

final _real = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

class TelaResultado extends StatelessWidget {
  final ResultadoInvestimento inv1;
  final ResultadoInvestimento inv2;

  const TelaResultado({super.key, required this.inv1, required this.inv2});

  Widget _resumo(String titulo, ResultadoInvestimento inv, Color cor) {
    const negrito = TextStyle(fontWeight: FontWeight.bold);
    return Expanded(
      child: Card(
        color: cor,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(titulo, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('Montante final'),
              Text(_real.format(inv.montanteFinal), style: negrito),
              const SizedBox(height: 8),
              const Text('Total investido'),
              Text(_real.format(inv.totalInvestido), style: negrito),
              const SizedBox(height: 8),
              const Text('Rendimento'),
              Text(_real.format(inv.rendimento),
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _linha(String mes, String valor1, String valor2, {bool cabecalho = false}) {
    final estilo = TextStyle(
      fontWeight: cabecalho ? FontWeight.bold : FontWeight.normal,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        children: [
          SizedBox(width: 50, child: Text(mes, style: estilo)),
          Expanded(child: Text(valor1, style: estilo, textAlign: TextAlign.right)),
          Expanded(child: Text(valor2, style: estilo, textAlign: TextAlign.right)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Comparação')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _resumo('Investimento 1', inv1, Colors.blue.shade50),
                _resumo('Investimento 2', inv2, Colors.orange.shade50),
              ],
            ),
          ),
          _linha('Mês', 'Investimento 1', 'Investimento 2', cabecalho: true),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              itemCount: inv1.evolucaoMensal.length,
              itemBuilder: (context, i) => _linha(
                '${i + 1}',
                _real.format(inv1.evolucaoMensal[i]),
                _real.format(inv2.evolucaoMensal[i]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}