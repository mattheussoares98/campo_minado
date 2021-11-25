import 'package:campo_minado/components/campo_widget.dart';
import 'package:campo_minado/models/campo.dart';
import 'package:campo_minado/models/tabuleiro.dart';
import 'package:flutter/material.dart';

class TabuleiroWidget extends StatelessWidget {
  final Tabuleiro tabuleiro;
  final Function(Campo) onAbir;
  final Function(Campo) onAlternar;

  const TabuleiroWidget({
    required this.tabuleiro,
    required this.onAbir,
    required this.onAlternar,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: tabuleiro.colunas,
      children: tabuleiro.campos
          .map(
            (campo) => CampoWidget(
              campo: campo,
              onPressed: onAbir,
              onLongPressed: onAlternar,
            ),
          )
          .toList(),
    );
  }
}
