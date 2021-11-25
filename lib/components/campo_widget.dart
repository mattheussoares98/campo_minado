import 'package:campo_minado/models/campo.dart';
import 'package:flutter/material.dart';

class CampoWidget extends StatelessWidget {
  final Campo campo;
  final void Function(Campo) onPressed;
  final void Function(Campo) onLongPressed;

  const CampoWidget({
    required this.campo,
    required this.onPressed,
    required this.onLongPressed,
    Key? key,
  }) : super(key: key);

  Widget get image {
    if (campo.minado && campo.explodido && campo.aberto) {
      return Image.asset('lib/assets/images/bomba_0.jpeg');
    } else if (campo.aberto && campo.minado) {
      return Image.asset('lib/assets/images/bomba_1.jpeg');
    } else if (campo.aberto) {
      return Image.asset(
          'lib/assets/images/aberto_${campo.qtsMinasNaVizinhanca}.jpeg');
    } else if (campo.marcado) {
      return Image.asset('lib/assets/images/bandeira.jpeg');
    } else {
      return Image.asset('lib/assets/images/fechado.jpeg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: image,
      onTap: () => onPressed(campo),
      onLongPress: () => onLongPressed(campo),
    );
  }
}
