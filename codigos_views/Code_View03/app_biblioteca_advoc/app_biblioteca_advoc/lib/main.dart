import 'package:appbibliotecaadvoc/models/cart_model.dart';
import 'package:appbibliotecaadvoc/screens/home_screen.dart';
import 'package:appbibliotecaadvoc/screens/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:appbibliotecaadvoc/models/user_model.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(
        builder: (context, child, model){
          return ScopedModel<CartModel>(
            model: CartModel(model), // Carrinho pegando acesso ao usuário atual
            child: MaterialApp(
              title: "Biblioteca de Advocacia",
              theme: ThemeData(
                  primarySwatch: Colors.blue,
                  primaryColor: Color.fromARGB(255, 4, 125, 141)
              ),
              debugShowCheckedModeBanner: false,
              home: HomeScreen(),
            ),
          );
        })
    );


  }
}