import 'dart:math';

import 'package:campo_minado/models/campo.dart';

class Tabuleiro {
  int linhas;
  int colunas;
  int qtdDeBombas;
  List<Campo> _campos = [];

  Tabuleiro({
    required this.linhas,
    required this.colunas,
    required this.qtdDeBombas,
  }) {
    _criarCampos();
    _relacionarVizinhos();
    _sortearMinas();
  }

  void _criarCampos() {
    for (var l = 0; l < linhas; l++) {
      for (var c = 0; c < colunas; c++) {
        _campos.add(
          Campo(coluna: c, linha: l),
        );
      }
    }
  }

  void _relacionarVizinhos() {
    for (var campo in _campos) {
      for (var vizinho in _campos) {
        campo.adicionarVizinho(vizinho);
      }
    }
  }

  void reinciar() {
    for (var element in _campos) {
      element.reiniciar();
    }
    _sortearMinas();
  }

  void _sortearMinas() {
    int sorteadas = 0;

    if (sorteadas > linhas * colunas) {
      return;
    }

    while (sorteadas < qtdDeBombas + 1) {
      int i = Random().nextInt(_campos.length);

      if (!_campos[i].minado) {
        _campos[i].minar();
        sorteadas++;
      }
    }
  }

  revelarBomba() {
    for (var element in _campos) {
      element.relevarBomba();
    }
  }

  List<Campo> get campos {
    return _campos;
  }

  bool get resolvido {
    return _campos.every((element) => element.resolvido);
    //se algum resultar em "falso", o bool vai resultar em falso também
  }
}
