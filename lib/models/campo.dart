import 'package:campo_minado/models/explosao_exception.dart';

class Campo {
  int linha;
  int coluna;
  List<Campo> vizinhos = [];

  //deixou esses booleanos como privado pra não conseguir mudar o valor deles fora dessa classe. Criou um get pra cada um deles pra conseguirem acessá-los
  bool _minado = false;
  bool _explodido = false;
  bool _aberto = false;
  bool _marcado = false;

  Campo({
    required this.linha,
    required this.coluna,
  });

  void adicionarVizinho(Campo vizinho) {
    final deltaLinha = (linha - vizinho.linha).abs();
    final deltaColuna = (coluna - vizinho.coluna).abs();

    if (deltaLinha == 0 && deltaColuna == 0) {
      return;
    }

    if (deltaColuna <= 1 && deltaLinha <= 1) {
      vizinhos.add(vizinho);
    }
  }

  void abrir() {
    if (_aberto) {
      return;
    }

    if (!_marcado) {
      _aberto = true;
    }

    if (_minado) {
      _explodido = true;
      throw ExplosaoException();
    }

    if (vizinhancaSegura) {
      for (var element in vizinhos) {
        element.abrir();
      }
    }
  }

  void relevarBomba() {
    if (_minado) {
      _aberto = true;
    }
  }

  void minar() {
    _minado = true;
  }

  void alternarMarcacao() {
    _marcado = !_marcado;
  }

  reiniciar() {
    _minado = false;
    _explodido = false;
    _aberto = false;
    _marcado = false;
  }

  bool get explodido {
    return _explodido;
  }

  bool get aberto {
    return _aberto;
  }

  bool get marcado {
    return _marcado;
  }

  bool get minado {
    return _minado;
  }

  bool get resolvido {
    bool abertoENaoMinado = aberto && !minado;
    bool marcadoEMinado = marcado && minado;
    return abertoENaoMinado || marcadoEMinado;
  }

  int get qtsMinasNaVizinhanca {
    return vizinhos.where((element) => element.minado).length;
  }

  bool get vizinhancaSegura {
    return vizinhos.every((element) => !element._minado);
  }
}
