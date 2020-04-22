import "package:flutter/material.dart";
import 'package:rotas/segundaTela.dart';
import 'primeiraTela.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => PrimeiraTela(),
        '/segundaTela': (context) => Tela2(),
      },
    );
  }
}
