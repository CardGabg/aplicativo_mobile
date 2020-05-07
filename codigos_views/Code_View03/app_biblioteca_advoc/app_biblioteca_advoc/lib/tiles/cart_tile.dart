import 'package:appbibliotecaadvoc/datas/cart_product.dart';
import 'package:appbibliotecaadvoc/datas/product_data.dart';
import 'package:appbibliotecaadvoc/models/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartTile extends StatelessWidget {

  final CartProduct cartProduct;

  CartTile(this.cartProduct);

  @override
  Widget build(BuildContext context) {

    Widget _buildContent(){
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            width: 120.0,
            child: Image.network(
              cartProduct.productData.image[0],
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // deixando as informações de texto com mesmo espaçamento em relação a imagem
                children: <Widget>[
                  Text(
                    cartProduct.productData.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0
                    ),
                  ),
                  Text("Autor: ${cartProduct.productData.authors}",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 17.0
                    ),
                  ),
                  Text("Editora: ${cartProduct.productData.publisher}",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 17.0
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                        child: Text("Remover"),
                        textColor: Colors.grey[500],
                        onPressed: (){
                          CartModel.of(context).removeCartItem(cartProduct);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      );
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0), // Utiliza-se a margin quando se quer dar um espaçamento fora do card
      child: cartProduct.productData == null ? // Se não temos o dado do produto, nós vamos busca-los no banco de dados
      FutureBuilder<DocumentSnapshot>(
        future: Firestore.instance.collection("produtos").document(cartProduct.category)
            .collection("items").document(cartProduct.pid).get(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            cartProduct.productData = ProductData.fromDocument(snapshot.data); // Salvando os dados para acessar novamente depois
            return _buildContent(); // mostrando o conteúdo do produto
          } else { // Caso esteja carregando esses dados, mostre uma tela de loading
            return Container(
              height: 70.0,
              child: CircularProgressIndicator(),
              alignment: Alignment.center,
            );
          }
        },
      ) : // Caso já tenha os dados do produto, chamamos apenas o _buildContent para mostrar o conteúdo do produto
      _buildContent()
    );
  }
}
