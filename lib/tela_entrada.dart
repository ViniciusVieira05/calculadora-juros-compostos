import 'package:flutter/material.dart';
import 'calculo.dart';
import 'cores.dart';
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

  List<TextEditingController> get _controladores =>
      [_meses, _capital1, _aporte1, _taxa1, _capital2, _aporte2, _taxa2];

  String _mensagem = '';

  double _numero(TextEditingController c) =>
      double.parse(c.text.replaceAll(',', '.'));

  void _limpar() {
    for (final c in _controladores) {
      c.clear();
    }
    setState(() => _mensagem = '');
  }

  Future<void> _calcular() async {
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
      final valor = 'R\$ ${diferenca.toStringAsFixed(2).replaceAll('.', ',')}';
      if (inv1.montanteFinal > inv2.montanteFinal) {
        _mensagem = 'O Investimento 1 rende $valor a mais';
      } else if (inv2.montanteFinal > inv1.montanteFinal) {
        _mensagem = 'O Investimento 2 rende $valor a mais';
      } else {
        _mensagem = 'Os dois investimentos rendem o mesmo valor';
      }
    });

    final reiniciar = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaResultado(inv1: inv1, inv2: inv2),
      ),
    );
    if (reiniciar == true) _limpar();
  }

  Widget _campo(TextEditingController controller, String rotulo,
      {String? prefixo, String? sufixo, bool inteiro = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.numberWithOptions(decimal: !inteiro),
        decoration: InputDecoration(
          labelText: rotulo,
          prefixText: prefixo,
          suffixText: sufixo,
        ),
        validator: (valor) {
          if (valor == null || valor.isEmpty) return 'Preencha este campo';
          final numero = inteiro
              ? int.tryParse(valor)
              : double.tryParse(valor.replaceAll(',', '.'));
          if (numero == null || numero < 0) return 'Digite um número válido';
          if (inteiro && numero == 0) return 'O período deve ser maior que zero';
          return null;
        },
      ),
    );
  }

  Widget _titulo(String texto, Color cor) {
    return Row(
      children: [
        Container(width: 4, height: 18, color: cor),
        const SizedBox(width: 8),
        Text(texto,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _cartao(String titulo, Color cor, TextEditingController capital,
      TextEditingController aporte, TextEditingController taxa) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _titulo(titulo, cor),
            const SizedBox(height: 16),
            _campo(capital, 'Capital inicial', prefixo: 'R\$ '),
            _campo(aporte, 'Aplicação mensal', prefixo: 'R\$ '),
            _campo(taxa, 'Taxa de juros', sufixo: '% ao mês'),
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
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
          children: [
            const Text('Compare dois investimentos',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text(
              'Preencha os dados abaixo para ver qual rende mais no mesmo período.',
              style: TextStyle(color: corTextoSuave),
            ),
            const SizedBox(height: 20),
            _campo(_meses, 'Período', sufixo: 'meses', inteiro: true),
            const SizedBox(height: 4),
            _cartao('Investimento 1', corInv1, _capital1, _aporte1, _taxa1),
            _cartao('Investimento 2', corInv2, _capital2, _aporte2, _taxa2),
            const SizedBox(height: 8),
            FilledButton(onPressed: _calcular, child: const Text('Comparar')),
            const SizedBox(height: 8),
            OutlinedButton(onPressed: _limpar, child: const Text('Limpar')),
            if (_mensagem.isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: corPrincipal.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  _mensagem,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: corPrincipal, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (final c in _controladores) {
      c.dispose();
    }
    super.dispose();
  }
}