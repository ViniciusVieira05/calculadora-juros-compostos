class ResultadoInvestimento {
  final double montanteFinal;
  final double totalInvestido;
  final double rendimento;
  final List<double> evolucaoMensal;

  ResultadoInvestimento({
    required this.montanteFinal,
    required this.totalInvestido,
    required this.rendimento,
    required this.evolucaoMensal,
  });
}

ResultadoInvestimento calcularInvestimento({
  required double capitalInicial,
  required double aporteMensal,
  required double taxaMensal,
  required int meses,
}) {
  double saldo = capitalInicial;
  final double taxa = taxaMensal / 100;
  final List<double> evolucao = [];

  for (int mes = 1; mes <= meses; mes++) {
    saldo = saldo * (1 + taxa);
    saldo = saldo + aporteMensal;
    evolucao.add(saldo);
  }

  final double totalInvestido = capitalInicial + aporteMensal * meses;

  return ResultadoInvestimento(
    montanteFinal: saldo,
    totalInvestido: totalInvestido,
    rendimento: saldo - totalInvestido,
    evolucaoMensal: evolucao,
  );
}