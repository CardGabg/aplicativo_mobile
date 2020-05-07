import 'package:appbibliotecaadvoc/blocs/user_bloc.dart';
import 'package:appbibliotecaadvoc/main.dart';
import 'package:appbibliotecaadvoc/screens/cart_screen.dart';
import 'package:appbibliotecaadvoc/tabs/category_tab.dart';
import 'package:appbibliotecaadvoc/tabs/home_tab.dart';
import 'package:appbibliotecaadvoc/tabs/orders_tab.dart';
import 'package:appbibliotecaadvoc/tabs/users_tab.dart';
import 'package:appbibliotecaadvoc/widgets/cart_button.dart';
import 'package:appbibliotecaadvoc/widgets/custom_drawer.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  PageController _pageController;

  UserBloc _userBloc;
//  BookBloc _bookBloc;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    _userBloc = UserBloc();

//    _bookBloc = BookBloc();

  }


  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView( // Os filhos dessa widgets são as telas do app
        controller: _pageController, // sempre que quiser mudar de página, basta usar esse método e colocar .jumpToPage ou .animateToPage
        physics: NeverScrollableScrollPhysics(), // Função que impossibilita deslizar as telas para os lados
        children: <Widget>[

          // TELA INICIO
          Scaffold(
            body: HomeTab(),
            drawer: CustomDrawer(_pageController),
            floatingActionButton: CartButton(),
          ),

          // TELA CATEGORIAS
          Scaffold(
            appBar: AppBar(
              title: Text("Categorias"),
              centerTitle: true,
            ),
            drawer: CustomDrawer(_pageController),
            floatingActionButton: CartButton(),
            body: CategoryTab(),

          ),

          // TELA MEUS PEDIDOS
          Scaffold(
            appBar: AppBar(
              title: Text("Meus Pedidos"),
              centerTitle: true,
            ),
            body: OrdersTab(),
            drawer: CustomDrawer(_pageController),
          ),

          // TELA VERIFICAÇÃO DE USUÁRIOS (SOMENTE ADMIN TERÁ ACESSO)
          BlocProvider<UserBloc>(
            bloc: _userBloc,
            child: Scaffold(
              backgroundColor: Colors.grey[850], // ( TELAS DE ADMIN TERÃO O FUNDO ESCURO )
              appBar: AppBar(
                title: Text("Usuários"),
                centerTitle: true,
              ),
              body: UsersTab(),
              drawer: CustomDrawer(_pageController),
            ),
          ),

//          // TELA VERIFICAÇÃO DE PEDIDOS (ADMIN)
//          Scaffold(
//            backgroundColor: Colors.grey[850],
//            appBar: AppBar(
//              title: Text("Usuários"),
//              centerTitle: true,
//            ),
//            body: UsersTab(),
//            drawer: CustomDrawer(_pageController),
//          ),
//
//          // TELA VERIFICAÇÃO DE LIVROS (ADMIN)
//          Scaffold(
//            backgroundColor: Colors.grey[850],
//            appBar: AppBar(
//              title: Text("Modificar Livros "),
//              centerTitle: true,
//            ),
//            body: UsersTab(),
//            drawer: CustomDrawer(_pageController),
//          ),

        ]
    );
  }
}
