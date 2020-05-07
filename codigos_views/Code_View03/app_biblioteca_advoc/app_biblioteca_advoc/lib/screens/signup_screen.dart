import 'package:appbibliotecaadvoc/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _registryController = TextEditingController();
  final _oabController = TextEditingController();
  final _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Cadastrar"),
        centerTitle: true,

      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model){
          if(model.isLoading) // Se estiver carregando, mostre o icone de carregar, senão, mostre o formulário
            return Center(child: CircularProgressIndicator(),);

          return Form(
            key: _formKey,
            child: ListView( // É importante colocar a ListView para que o teclado não cubra a tela
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: "Nome Completo ",
                  ),
                  keyboardType: TextInputType.text,
                  // ignore: missing_return
                  validator: (text){
                    if(text.isEmpty) return "Nome Inválido!";
                  },
                ),
                TextFormField(
                  controller: _registryController,
                  decoration: InputDecoration(
                    hintText: "Matrícula ",
                  ),
                  keyboardType: TextInputType.number,
                  // ignore: missing_return
                  validator: (text){
                    if(text.isEmpty || text.length < 8) return "Matrícula Inválida!";
                  },
                ),
                TextFormField(
                  controller: _oabController,
                  decoration: InputDecoration(
                    hintText: "OAB (Opcional) ",
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "E-mail ",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  // ignore: missing_return
                  validator: (text){
                    if(text.isEmpty || !text.contains("@")) return "E-mail inválido!";
                  },
                ),
                SizedBox(height: 16.0,), // Espaçamento
                TextFormField(
                  controller: _passController,
                  decoration: InputDecoration(
                      hintText: "Senha "
                  ),
                  obscureText: true, // esconde o campo senha
                  // ignore: missing_return
                  validator: (text){
                    if(text.isEmpty || text.length < 6) return "Senha inválida!";
                  },
                ),
                SizedBox(height: 16.0,), // Espaçamento
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                      child: Text( "Cadastrar",
                        style:TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: (){
                        if(_formKey.currentState.validate()){

                          Map<String, dynamic> userData = {
                            "name": _nameController.text,
                            "registry": _registryController.text,
                            "oab": _oabController.text,
                            "email": _emailController.text,
                          };

                          model.signUp(
                              userData: userData,
                              pass: _passController.text,
                              onSuccess: _onSuccess,
                              onFail: _onFail
                          );
                        }
                      }
                  ),
                ),
              ],
            ),
          );
        },
      )
    );
  }

  void _onSuccess(){
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text("Usuário criado com sucesso!"),
        backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: 2),
      )
    );
    Future.delayed(Duration(seconds: 2)).then((_){
      Navigator.of(context).pop();
    });
  }

  void _onFail(){
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Falha ao criar usuário!"),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        )
    );
  }

}

