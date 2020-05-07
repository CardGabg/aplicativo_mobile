import 'package:appbibliotecaadvoc/datas/product_data.dart';
import 'package:appbibliotecaadvoc/screens/product_screen.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {

  final String type;
  final ProductData product;


  ProductTile(this.type, this.product);

  @override
  Widget build(BuildContext context) {
    return InkWell( // Faz uma animação quando você toca no card
      onTap: (){ // Função para quando o usuario apertar no produto, ele abrirá a tela do produto
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ProductScreen(product))
        );
      },
      child: Card( // É um cartão que tem uma elevação (No caso utilizaremos 2 tipos de card e precisamos especificar)
        child: type == "grid" ? // Se o Card for do tipo grid coloque os itens em uma coluna
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // stretch pra poder esticar a imagem pra caber no card certinho
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            AspectRatio( // Serve para deixar o card num tamanho definido para não variar pela tela de cada dispositivo móvel (É a largura dividida pela altura do card)
              aspectRatio: 0.9,
              child: Image.network(
                product.image[0],
                fit: BoxFit.cover, // cobre o espaço disponivel do card
              ),
            ),
            Expanded( // Aqui será criado um espaço que colocará o titulo e o preço do produto
              child: Container(
                padding: EdgeInsets.all(9.0),
                child: Column(
                  children: <Widget>[
                    Divider(),
                    Text(product.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
            : Row( // Caso o card não seja grid, faça uma linha (lista)
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 0.8,
                      child: Image.network(
                        product.image[0],
                        fit: BoxFit.cover,
                        height: 250.0, // Tamanho do card
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(product.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0
                      ),
                    ),
                    Divider(),
                    Text("Autor:",
                      style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold
                      ),
                    ), Text(product.authors),
                    Divider(),
                    Text("Editora:",
                      style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                      ),
                    ),Text(product.publisher)
                  ],
                ),
              ),
            ),
          ],
        ),

      ),
    );

  }
}
