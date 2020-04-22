import 'package:flutter/material.dart';
import 'segundaTela.dart';

class Parametros{
  String titulo;
  String descricao;
  Parametros(this.titulo, this.descricao);
}

class PrimeiraTela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tela 01"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
                child: Text("Segunda Tela"),
                onPressed: () {
                  Navigator.pushNamed(context, '/segundaTela',
                  arguments: Parametros(
                    "titulo 01",
                    "bla bla bla"
                  )
                  );
                })
          ],
        ),
      ),
    );
  }
}
