import 'package:flutter/material.dart';

class FormularioDetalhe extends StatefulWidget {
  @override
  _FormularioDetalheState createState() => _FormularioDetalheState();
}

class _FormularioDetalheState extends State<FormularioDetalhe> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Formulário"),
        ),
        body: Builder(builder: (BuildContext context) {
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: _textController,
                    decoration: InputDecoration(
                      labelText: "Nome Completo",
                      suffixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10)
                        ),
                      )
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Entre com o nome";
                      }
                      return null;
                    },
                  ),
                ),
                RaisedButton(
                    child: Text("Cadastrar"),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(_textController.text),
                        ));
                      }
                    })
              ],
            ),
          );
        }));
  }
}
