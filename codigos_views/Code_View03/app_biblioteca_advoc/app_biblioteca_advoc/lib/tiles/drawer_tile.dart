import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {

  final IconData icon;
  final String text;
  final PageController controller;
  final int page;
//  final int page;

  DrawerTile(this.icon, this.text, this.controller, this.page); // Construtor que cria um ícone e um texto pra cada item do Drawer

  @override
  Widget build(BuildContext context) {
    return Material( // Utilizamos o Material pois queremos que ao apertar no DrawerTile ele tenha um efeito visual
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop(); // função para fechar o drawer quando mudar de página
          controller.jumpToPage(page); // função para pular de página
        },
        child: Container(
          height: 60.0,
          child: Row(
            children: <Widget>[
              Icon(icon, size: 32.0,
                color: controller.page.round() == page ? // Se o controller estiver na página selecionada faça: vvv (OBS: o .page é um valor double e nós declaramos o page como int, então usamos o .round para arredondar
                Theme.of(context).primaryColor : // Usar a cor tema da primary color, senão: vvv
                Colors.grey[700], // deixa na cor cinza com tonalidade 700
              ),
              SizedBox(width: 32.0,),
              Text(
                text,
                style: TextStyle(
                    fontSize: 16.0,
                    color: controller.page.round() == page ?
                    Theme.of(context).primaryColor : Colors.grey[700]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


