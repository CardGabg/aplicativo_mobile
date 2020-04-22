import 'package:flutter/material.dart';
import 'formulario.dart';

void main() => runApp(Formulario());

class Formulario extends StatefulWidget {
  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => FormularioDetalhe(),
      },
    );
  }
}