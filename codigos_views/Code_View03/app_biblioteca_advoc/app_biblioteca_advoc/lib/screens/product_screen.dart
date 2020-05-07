import 'package:appbibliotecaadvoc/datas/cart_product.dart';
import 'package:appbibliotecaadvoc/models/cart_model.dart';
import 'package:appbibliotecaadvoc/models/user_model.dart';
import 'package:appbibliotecaadvoc/screens/login_screen.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:appbibliotecaadvoc/datas/product_data.dart';

import 'cart_screen.dart';

class ProductScreen extends StatefulWidget {

  final ProductData product;

  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData product;

  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {

    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1,
            child: Carousel(
              images: product.image.map((url){
                return NetworkImage(url);
              }).toList(),
              dotSize: 4.0,
              dotBgColor: Colors.transparent,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  product.title,
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold
                  ),
                  maxLines: 3, // Definindo a quantidade máxima de linhas pro título
                ),
                Divider(),
                Text(
                  "Autores: ${product.authors}",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  "Editora: ${product.publisher}",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  "Preço pago: R\$ ${product.price.toStringAsFixed(2)}", // .toStringAsFixed para aumentar as casas decimais do preço
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Divider(),
                Text(
                  "Unidades: ",
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 16.0,),
                SizedBox(
                  height: 48.0,
                  child: RaisedButton(
                    onPressed: (){
                      if(UserModel.of(context).isLoggedIn()){
                        //adicionando ao carrinho
                        CartProduct cartProduct = CartProduct();
                        cartProduct.quantity = 1;
                        cartProduct.pid = product.id;
                        cartProduct.category = product.category;
                        cartProduct.productData = product;

                        CartModel.of(context).addCartItem(cartProduct); // adicionando

                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=>CartScreen())
                        );
                      } else { // Se não estiver logado, mude pra tela de Login
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=>LoginScreen())
                        );
                      }
                    },
                    child: Text(UserModel.of(context).isLoggedIn() ? "Adicionar ao Carrinho"
                      : "Entre para Emprestar",
                    style: TextStyle(fontSize: 18.0),
                    ),
                    color: primaryColor,
                    textColor: Colors.white,

                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
