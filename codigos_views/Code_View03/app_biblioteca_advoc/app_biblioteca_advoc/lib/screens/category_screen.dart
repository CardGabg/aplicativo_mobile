import 'package:appbibliotecaadvoc/datas/product_data.dart';
import 'package:appbibliotecaadvoc/tiles/product_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {

  final DocumentSnapshot snapshot;

  CategoryScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(snapshot.data["title"]),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.grid_on),),
              Tab(icon: Icon(Icons.list),),
            ],
          ),
        ),
        body: FutureBuilder<QuerySnapshot>( // especificando o FutureBuilder, o sistema identificará mais facilmente os erros que possam vir a ocorrer (<QuerySnapshot>)
          // O DocumentSnapshot é a fotografia de apenas um documento, já o QuerySnapshot é a fotografia de uma coleção de documentos, ou sejá, vários
            future: Firestore.instance.collection("produtos") // Acessando a coleção produtos do banco de dados
                .document(snapshot.documentID) // Acessando o documento pra pegar a categoria (O snapshot de acesso a categoria foi declarado lá em cima)
                .collection("items").getDocuments(), // Acessando a coleção items e pegando todos os documentos
            builder: (context, snapshot) {
              if(!snapshot.hasData)
                return Center(child: CircularProgressIndicator(),
                );
              else
                return TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    GridView.builder( //GridView para mostrar os itens em grade. O .builder é para não carregar todos os itens de uma vez, pois ficaria pesado carregar tudo ao mesmo tempo
                        padding: EdgeInsets.all(4.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount( // Quantos itens teremos na horizontal
                          crossAxisCount: 2, // Espaçamento entre cada item
                          mainAxisSpacing: 4.0, // Espaçamento no eixo principal
                          crossAxisSpacing: 4.0, // Eixo cruzado
                          childAspectRatio: 0.65, // Esse é a divisão entre a largura do item pela altura do item
                        ),
                        itemCount: snapshot.data.documents.length, // Recebendo todos os itens do documento e cada documento é um produto da categoria
                        itemBuilder: (context, index){ // Vai retornar o item que queremos mostrar em cada posição
                          ProductData data = ProductData.fromDocument(snapshot.data.documents[index]); // Transformando todos os documentos recebidos num ProductData
                          data.category = this.snapshot.documentID;
                          return ProductTile("grid", data);
                        }
                    ),

                    ListView.builder( // ListView para mostrar os itens em lista
                        padding: EdgeInsets.all(4.0),
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index){
                          ProductData data = ProductData.fromDocument(snapshot.data.documents[index]); // Transformando todos os documentos recebidos num ProductData
                          data.category = this.snapshot.documentID;
                          return ProductTile("list", data);
                        }
                    )

                  ],
                );
            }
        ),
      ),
    );
  }
}