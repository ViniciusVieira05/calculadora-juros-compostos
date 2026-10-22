# 💰 Simulador de Investimentos: Comparação de Rendimentos

Aplicativo Flutter desenvolvido para a disciplina de **Programação para Dispositivos Móveis**. Ele permite comparar **dois investimentos diferentes** usando juros compostos com aplicação mensal, mostrando qual deles rende mais e como o dinheiro evolui mês a mês.

## 🎥 Vídeo de demonstração

[Clique aqui para assistir ao vídeo](COLE_AQUI_O_LINK_DO_VIDEO)

## 📱 Funcionalidades

- **Formulário de entrada** com os dados dos dois investimentos:
  - Capital inicial (para cada investimento)
  - Aplicação mensal (para cada investimento)
  - Taxa de juros mensal (para cada investimento)
  - Período em meses (compartilhado entre os dois)
- **Validação dos campos**: o app avisa se algum campo estiver vazio, com texto ou com valor negativo
- **Aceita vírgula ou ponto** nos números (ex.: `1,5` ou `1.5`)
- **Mensagem na tela inicial** indicando qual investimento rende mais e a diferença entre eles
- **Tela de resultados** com:
  - Resumo lado a lado: montante final, total investido e rendimento de cada investimento
  - Barras comparativas mostrando visualmente a diferença entre os montantes
  - Lista comparativa com a evolução mês a mês dos dois investimentos
- **Valores formatados em reais** (ex.: R$ 1.333,31)
- **Botão "Nova simulação"** para voltar e começar uma comparação do zero
- **Botão "Limpar"** para apagar todos os campos do formulário

## 🧮 Como o cálculo funciona

A cada mês, o saldo primeiro rende juros e depois recebe a aplicação mensal:

```
saldo = saldo × (1 + taxa) + aplicação mensal
```

Ao final do período:

- **Montante final** = saldo após o último mês
- **Total investido** = capital inicial + (aplicação mensal × meses)
- **Rendimento** = montante final − total investido

**Exemplo:** capital de R$ 1.000, aplicação de R$ 100 e taxa de 1% ao mês, por 3 meses:

| Mês | Conta | Saldo |
|-----|-------|-------|
| 1 | 1.000,00 × 1,01 + 100 | R$ 1.110,00 |
| 2 | 1.110,00 × 1,01 + 100 | R$ 1.221,10 |
| 3 | 1.221,10 × 1,01 + 100 | R$ 1.333,31 |

Total investido: R$ 1.300,00 · Rendimento: **R$ 33,31**

## 🗂️ Estrutura do projeto

```
lib/
├── main.dart            → ponto de partida e tema do app
├── calculo.dart         → lógica dos juros compostos (função reutilizável)
├── tela_entrada.dart    → formulário com os dados dos dois investimentos
└── tela_resultado.dart  → comparação lado a lado, barras e lista mensal
```

## 🛠️ Conceitos de Flutter utilizados

| Conceito | Onde foi usado |
|----------|----------------|
| `Form` e `TextFormField` com validação | Tela de entrada |
| `StatefulWidget` e `setState` | Tela de entrada (mensagem de resultado e limpeza do formulário) |
| `StatelessWidget` | App principal e tela de resultados |
| `Navigator.push` e `Navigator.pop` | Navegação entre entrada e resultados |
| `ListView` e `ListView.builder` | Formulário rolável e lista mês a mês |
| Métodos que retornam widgets | `_campo`, `_cartao`, `_resumo`, `_barra`, `_linha` |
| Pacote `intl` | Formatação de valores em reais |

## ▶️ Como executar

Pré-requisitos: [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado e um emulador ou celular conectado.

```bash
git clone COLE_AQUI_O_LINK_DO_REPOSITORIO
cd calculadora_juros_compostos
flutter pub get
flutter run
```

> ⚠️ No Windows, salve o projeto em uma pasta **sem acentos e sem espaços** no caminho, senão a compilação para Android falha.

## 👤 Autor

**SEU NOME** · Programação para Dispositivos Móveis
