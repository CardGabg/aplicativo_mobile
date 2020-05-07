import 'dart:ffi';

import 'package:appbibliotecaadvoc/models/user_model.dart';
import 'package:appbibliotecaadvoc/tiles/drawer_tile.dart';
import 'package:flutter/material.dart';
import 'package:appbibliotecaadvoc/screens/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {

  final PageController pageController;

  CustomDrawer(this.pageController);


  @override
  Widget build(BuildContext context) {

    Widget _buildDrawerBack() => Container( // Essa função foi criada para fazer um background em degradê
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 203, 236, 241),
              Colors.white
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
        ),
      ),
    );
    return Drawer(
        child: Stack(
          children: <Widget>[
            _buildDrawerBack(),
            ListView(
              padding: EdgeInsets.only(left: 32.0, top: 16.0),
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 8.0),
                  padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                  height: 170.0,
                  child:  Stack( // Poderia utilizar uma Column, mas utiliza o Stack para ter mais liberdade de posicionamento de cada um dos elementos
                    children: <Widget>[
                      Positioned( // Configuração do Stack: Ele está a 8.0 de distancia do topo e 0.0 de distancia da esquerda
                        top: 8.0,
                        left: 0.0,
                        child: Text("Biblioteca\nAdvocacia", // o \n é para quebrar a linha
                          style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Positioned(
                          left: 0.0,
                          bottom: 0.0,
                          child: ScopedModelDescendant<UserModel>(
                            builder: (context, child, model){
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Olá, ${!model.isLoggedIn() ? "" : model.userData["name"]}",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  GestureDetector( // Torna o texto clicável e fazendo alguma ação quando clicar
                                    child: Text(
                                      !model.isLoggedIn() ?
                                      "Entre ou cadastre-se >"
                                      : "sair",
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    onTap: () {
                                      if(!model.isLoggedIn())
                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => LoginScreen()),
                                      );
                                      else
                                        model.signOut();
                                    },
                                  )
                                ],
                              );
                            },
                          )
                      )
                    ],
                  ),
                ),
                Divider(), // criando uma divisão pra poder fazer os itens do DrawerTile
                DrawerTile(Icons.home, "Início", pageController, 0),
                DrawerTile(Icons.book, "Categoria de Livros", pageController, 1),
                DrawerTile(Icons.shop_two, "Meus Pedidos", pageController, 2),
                Divider(),
                DrawerTile(Icons.person, "Verificar Usuários", pageController, 3),
                DrawerTile(Icons.assignment, "Verificar Pedidos", pageController, 4),
                DrawerTile(Icons.library_books, "Modificar Livros", pageController, 5),
              ],
            ),
          ],
        )
    );
  }
}
