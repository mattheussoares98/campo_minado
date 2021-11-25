import 'package:campo_minado/components/resultado_widget.dart';
import 'package:campo_minado/components/tabuleiro_widget.dart';
import 'package:campo_minado/models/campo.dart';
import 'package:campo_minado/models/explosao_exception.dart';
import 'package:campo_minado/models/tabuleiro.dart';
import 'package:flutter/material.dart';

class CampoMinadoApp extends StatefulWidget {
  const CampoMinadoApp({Key? key}) : super(key: key);

  @override
  State<CampoMinadoApp> createState() => _CampoMinadoAppState();
}

class _CampoMinadoAppState extends State<CampoMinadoApp> {
  bool _venceu = false;
  bool _jogando = true;
  Tabuleiro? _tabuleiro;

  reiniciar() {
    setState(() {
      _jogando = true;
      _venceu = false;
      _tabuleiro!.reinciar();
    });
  }

  void abrir(Campo campo) {
    setState(() {
      try {
        if (campo.marcado) {
          return;
        }
        if (_jogando == true) {
          campo.abrir();
        }
        if (_tabuleiro!.resolvido) {
          _jogando = false;
          _venceu = true;
          _tabuleiro!.revelarBomba();
        }
      } on ExplosaoException {
        _venceu = false;
        _jogando = false;
        _tabuleiro!.revelarBomba();
      }
      if (_tabuleiro!.resolvido) {
        _jogando = false;
        _venceu = true;
        _tabuleiro!.revelarBomba();
      }
    });
  }

  void alternar(Campo campo) {
    if (_jogando == false) {
      return;
    }
    setState(() {
      campo.alternarMarcacao();
    });

    if (_tabuleiro!.resolvido) {
      setState(() {
        _jogando = false;
        _venceu = true;
      });
    }
  }

  Tabuleiro _getTabuleiro(double largura, double altura) {
    if (_tabuleiro == null) {
      int quantidadeColunas = 15;
      double tamanhoCampo = largura / quantidadeColunas;
      int qtdDeLinhas = (altura / tamanhoCampo).floor();

      _tabuleiro = Tabuleiro(
        linhas: qtdDeLinhas,
        colunas: 15,
        qtdDeBombas: 50,
      );
    }

    return _tabuleiro!;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: ResultadoWidget(
          jogando: _jogando,
          venceu: _venceu,
          onReiniciar: reiniciar,
        ),
        body: LayoutBuilder(builder: (
          ctx,
          constraints,
        ) {
          return TabuleiroWidget(
            tabuleiro: _getTabuleiro(
              constraints.maxWidth,
              constraints.maxHeight,
            ),
            onAbir: abrir,
            onAlternar: alternar,
          );
        }),
      ),
    );
  }
}
