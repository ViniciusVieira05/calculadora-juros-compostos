import 'package:flutter/material.dart';
import 'calculo.dart';
import 'tela_resultado.dart';

class TelaEntrada extends StatefulWidget {
  const TelaEntrada({super.key});

  @override
  State<TelaEntrada> createState() => _TelaEntradaState();
}

class _TelaEntradaState extends State<TelaEntrada> {

  final _formKey = GlobalKey<FormState>();

  final _meses = TextEditingController();
  final _capital1 = TextEditingController();
  final _aporte1 = TextEditingController();
  final _taxa1 = TextEditingController();
  final _capital2 = TextEditingController();
  final _aporte2 = TextEditingController();
  final _taxa2 = TextEditingController();

  String _mensagem = '';

  double _numero(TextEditingController c) =>
      double.parse(c.text.replaceAll(',', '.'));

  void _calcular() {
    if (!_formKey.currentState!.validate()) return;

    final meses = int.parse(_meses.text);

    final inv1 = calcularInvestimento(
      capitalInicial: _numero(_capital1),
      aporteMensal: _numero(_aporte1),
      taxaMensal: _numero(_taxa1),
      meses: meses,
    );
    final inv2 = calcularInvestimento(
      capitalInicial: _numero(_capital2),
      aporteMensal: _numero(_aporte2),
      taxaMensal: _numero(_taxa2),
      meses: meses,
    );

    setState(() {
      final diferenca = (inv1.montanteFinal - inv2.montanteFinal).abs();
      final valor = 'R\$ ${diferenca.toStringAsFixed(2)}';
      if (inv1.montanteFinal > inv2.montanteFinal) {
        _mensagem = 'O Investimento 1 rende $valor a mais';
      } else if (inv2.montanteFinal > inv1.montanteFinal) {
        _mensagem = 'O Investimento 2 rende $valor a mais';
      } else {
        _mensagem = 'Os dois investimentos rendem o mesmo valor';
      }
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaResultado(inv1: inv1, inv2: inv2),
      ),
    );
  }

  Widget _campo(TextEditingController controller, String rotulo,
      {bool inteiro = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.numberWithOptions(decimal: !inteiro),
        decoration: InputDecoration(
          labelText: rotulo,
          border: const OutlineInputBorder(),
        ),
        validator: (valor) {
          if (valor == null || valor.isEmpty) return 'Preencha este campo';
          final numero = inteiro
              ? int.tryParse(valor)
              : double.tryParse(valor.replaceAll(',', '.'));
          if (numero == null || numero < 0) return 'Digite um número válido';
          if (inteiro && numero == 0) return 'O período deve ser maior que zero';
          return null; // null = campo válido
        },
      ),
    );
  }

  Widget _cartao(String titulo, TextEditingController capital,
      TextEditingController aporte, TextEditingController taxa) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(titulo,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _campo(capital, 'Capital inicial (R\$)'),
            _campo(aporte, 'Aplicação mensal (R\$)'),
            _campo(taxa, 'Taxa de juros mensal (%)'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simulador de Investimentos')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _campo(_meses, 'Período (meses)', inteiro: true),
            _cartao('Investimento 1', _capital1, _aporte1, _taxa1),
            _cartao('Investimento 2', _capital2, _aporte2, _taxa2),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _calcular,
              child: const Text('Comparar'),
            ),
            const SizedBox(height: 16),
            Text(
              _mensagem,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (final c in [_meses, _capital1, _aporte1, _taxa1, _capital2, _aporte2, _taxa2]) {
      c.dispose();
    }
    super.dispose();
  }
}