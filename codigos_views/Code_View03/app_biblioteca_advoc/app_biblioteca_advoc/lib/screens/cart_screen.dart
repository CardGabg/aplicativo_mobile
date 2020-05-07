import 'package:appbibliotecaadvoc/models/cart_model.dart';
import 'package:appbibliotecaadvoc/models/user_model.dart';
import 'package:appbibliotecaadvoc/screens/login_screen.dart';
import 'package:appbibliotecaadvoc/screens/order_screen.dart';
import 'package:appbibliotecaadvoc/tiles/cart_tile.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Meu Carrinho"),
        centerTitle: true,
        actions: <Widget>[ // mostrará a quantidade de itens o usuário possui no carrinho
          Container(
            padding: EdgeInsets.only(right: 8.0),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model){
                int p = model.products.length; // quantidade de produtos no carrinho
                return Text(
                  "${p ?? 0} ${p == 1 ? " ITEM" : "ITENS"} ",// Se p for nulo, ele retorna 0, caso contrário ele retorna o valor de p  |  se p for 1 então mostra ITEM, senão mostra ITENS
                  style: TextStyle(fontSize: 17.0),
                );
              },
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
        // ignore: missing_return
        builder: (context, child, model){
          if(model.isLoading && UserModel.of(context).isLoggedIn()){
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if(!UserModel.of(context).isLoggedIn()){ // TELA MOSTRADA SE O USUÁRIO NÃO ESTIVER LOGADO
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.remove_shopping_cart, size: 80.0, color: Theme.of(context).primaryColor,),
                  SizedBox(height: 16.0,), // Espeaçamento
                  Text("Faça o login para adicionar produtos!",
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.0,), // Espeaçamento
                  Card(
                    margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: SizedBox(
                      height: 50.0,
                      child: RaisedButton(
                        child: Text("Entrar", style: TextStyle(fontSize: 18.0,),
                        ),
                        textColor: Colors.white,
                        color: Theme.of(context).primaryColor,
                        onPressed: (){
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => LoginScreen())
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          } else if(model.products == null || model.products.length == 0) { // TELA MOSTRADA SE O USUÁRIO ESTÁ LOGADO PORÉM NÂO TEM PRODUTO NO CARRINHO
            return Center(
              child: Text("Nenhum produto no carrinho!",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              ),
            );
          } else { // TELA COM OS PRODUTOS QUE O USUARIO ADICIONOU AO CARRINHO
            return ListView( // Podemos ter vários produtos, então para podermos rolar a tela entre os produtos do carrinho, utilizamos o ListView
              children: <Widget>[
                Column(
                  children: model.products.map( // Pegando cada um dos produtos da lista de produtos
                      (product){
                        return CartTile(product); // e transformando em um CartTile
                      }
                ).toList(),
                ),
                Card(
                margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: SizedBox(
                    height: 50.0,
                    child: RaisedButton(
                      child: Text( "Efetuar Empréstimo",
                        style:TextStyle(fontSize: 18.0,),
                      ),
                      textColor: Colors.white,
                      color: Colors.green,
                      onPressed: () async {
                        if(model.products.length > 4){
                          _scaffoldKey.currentState.showSnackBar(
                            SnackBar(content: Text("Você só pode adicionar 4 produtos por empréstimo!"),
                            backgroundColor: Colors.redAccent,
                            duration: Duration(seconds: 4),
                            )
                          );
                        } else {
                        String orderId = await model.finishOrder();
                        if(orderId != null)
                          Navigator.of(context).pushReplacement( // pushReplacement para substituir a tela do carrinho pela tela de confirmação
                            MaterialPageRoute(builder: (context) => OrderScreen(orderId))
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            );
          }
        }
      ),
    );
  }
}
