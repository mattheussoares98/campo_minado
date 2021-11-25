import 'package:flutter/material.dart';

class ResultadoWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool venceu;
  final bool jogando;
  final Function() onReiniciar;
  const ResultadoWidget({
    required this.venceu,
    required this.jogando,
    required this.onReiniciar,
    Key? key,
  }) : super(key: key);

  IconData get getIcon {
    if (venceu == false && jogando == false) {
      return Icons.sentiment_dissatisfied_outlined;
    } else if (jogando == true && venceu == false) {
      return Icons.sentiment_neutral;
    } else {
      return Icons.sentiment_satisfied_outlined;
    }
  }

  Color get getCor {
    if (jogando == true && venceu == false) {
      return Colors.yellow;
    } else if (jogando == false && venceu == true) {
      return Colors.green[300]!;
    } else {
      return Colors.red[300]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      color: Colors.grey,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Clique no ícone pra reiniciar o jogo',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: getCor,
                    child: IconButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: onReiniciar,
                      icon: Icon(
                        getIcon,
                        color: Colors.black,
                        size: 35,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  if (venceu == true)
                    const Text(
                      'VOCÊ VENCEU!!!',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (venceu == false && jogando == false)
                    const Text(
                      'VOCÊ PERDEU!!!',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}
