import "package:flutter/material.dart";
import 'package:rotas/primeiraTela.dart';

class Tela2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Parametros parametro = ModalRoute.of(context).settings.arguments;
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text("Tela 02"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(parametro.titulo),
            RaisedButton(
              child: Text("Voltar"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    ));
  }
}
