import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'calculo.dart';
import 'cores.dart';

final _real = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

const _numeros = [FontFeature.tabularFigures()];

class TelaResultado extends StatelessWidget {
  final ResultadoInvestimento inv1;
  final ResultadoInvestimento inv2;

  const TelaResultado({super.key, required this.inv1, required this.inv2});

  Widget _dado(String rotulo, double valor, {bool destaque = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(rotulo,
              style: const TextStyle(fontSize: 12, color: corTextoSuave)),
          Text(
            _real.format(valor),
            style: TextStyle(
              fontSize: destaque ? 18 : 14,
              fontWeight: destaque ? FontWeight.bold : FontWeight.w500,
              fontFeatures: _numeros,
            ),
          ),
        ],
      ),
    );
  }

  Widget _resumo(String titulo, ResultadoInvestimento inv, Color cor,
      bool vencedor) {
    return Expanded(
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(width: 4, height: 16, color: cor),
                  const SizedBox(width: 6),
                  Text(titulo,
                      style: TextStyle(fontWeight: FontWeight.w600, color: cor)),
                ],
              ),
              _dado('Montante final', inv.montanteFinal, destaque: true),
              _dado('Total investido', inv.totalInvestido),
              _dado('Rendimento', inv.rendimento),
              if (vencedor) ...[
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: cor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text('Rende mais',
                      style: TextStyle(
                          fontSize: 12, color: cor, fontWeight: FontWeight.w600)),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _barra(String titulo, double valor, double maior, Color cor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
              width: 100,
              child: Text(titulo, style: const TextStyle(fontSize: 13))),
          Expanded(
            child: LinearProgressIndicator(
              value: maior == 0 ? 0 : valor / maior,
              minHeight: 10,
              color: cor,
              backgroundColor: const Color(0xFFECEAE4),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _linha(String mes, String valor1, String valor2,
      {bool cabecalho = false, bool listrada = false}) {
    final estilo = TextStyle(
      fontSize: cabecalho ? 12 : 14,
      fontWeight: cabecalho ? FontWeight.w600 : FontWeight.normal,
      color: cabecalho ? corTextoSuave : Colors.black87,
      fontFeatures: _numeros,
    );
    return Container(
      color: listrada ? const Color(0xFFF8F7F3) : Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Row(
        children: [
          SizedBox(width: 50, child: Text(mes, style: estilo)),
          Expanded(
              child: Text(valor1, style: estilo, textAlign: TextAlign.right)),
          Expanded(
              child: Text(valor2, style: estilo, textAlign: TextAlign.right)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final maior = inv1.montanteFinal > inv2.montanteFinal
        ? inv1.montanteFinal
        : inv2.montanteFinal;

    return Scaffold(
      appBar: AppBar(title: const Text('Resultado')),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton.icon(
            onPressed: () => Navigator.pop(context, true),
            icon: const Icon(Icons.refresh),
            label: const Text('Nova simulação'),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _resumo('Investimento 1', inv1, corInv1,
                      inv1.montanteFinal > inv2.montanteFinal),
                  const SizedBox(width: 12),
                  _resumo('Investimento 2', inv2, corInv2,
                      inv2.montanteFinal > inv1.montanteFinal),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _barra('Investimento 1', inv1.montanteFinal, maior, corInv1),
                _barra('Investimento 2', inv2.montanteFinal, maior, corInv2),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  _linha('MÊS', 'INVEST. 1', 'INVEST. 2', cabecalho: true),
                  const Divider(height: 1),
                  Expanded(
                    child: ListView.builder(
                      itemCount: inv1.evolucaoMensal.length,
                      itemBuilder: (context, i) => _linha(
                        '${i + 1}',
                        _real.format(inv1.evolucaoMensal[i]),
                        _real.format(inv2.evolucaoMensal[i]),
                        listrada: i.isOdd,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}