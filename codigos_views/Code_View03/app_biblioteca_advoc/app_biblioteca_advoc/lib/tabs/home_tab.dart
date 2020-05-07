import 'package:appbibliotecaadvoc/datas/product_data.dart';
import 'package:appbibliotecaadvoc/screens/product_screen.dart';
import 'package:appbibliotecaadvoc/tiles/category_tile.dart';
import 'package:appbibliotecaadvoc/tiles/home_tile.dart';
import 'package:appbibliotecaadvoc/tiles/product_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    Widget _buildBodyBack() => Container( // Essa função foi criada para fazer um background em degradê
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 211, 118, 130),
              Color.fromARGB(255, 253, 181, 168),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
        ),
      ),
    );


    return Stack( // Usado para colocar coisas uma em cima da outra (sobreposição)
      children: <Widget>[
        _buildBodyBack(), // Chamando a função do Background degradê criado
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar( // Essa é a configuração de uma AppBar personalizada que permite com que ela desça juntamente com o conteúdo após o usuário deslizar a página
              floating: true, // Flutuante, transforma a appBar em flutuante e faz com que a barra desapareça quando desliza
              snap:  true, // A barra reaparece quando não está deslizando
              backgroundColor: Colors.transparent, // Background transparente
              elevation: 0.0, // Colocando a barra no mesmo plano do conteúdo da página, sem deixar sombras
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Biblioteca"),
                centerTitle: true,
              ),
            ),
          ],
        ),

          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 80.0),
                  child: TextField(
                    style: TextStyle(color: Colors.white,),
                    decoration: InputDecoration(
                    hintText: "Pesquisar",
                    hintStyle: TextStyle(color: Colors.white),
                    icon: Icon(Icons.search, color: Colors.white,),
                    border: InputBorder.none
                  ),
                ),
              ),

            ],
          ),
      ]
    );

  }
}
