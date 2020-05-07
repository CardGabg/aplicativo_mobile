import 'package:appbibliotecaadvoc/blocs/user_bloc.dart';
import 'package:appbibliotecaadvoc/tiles/user_tile.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class UsersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final _userBloc = BlocProvider.of<UserBloc>(context);

    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0,),
          child: TextField(
              style: TextStyle(color: Theme.of(context).primaryColor,),
              decoration: InputDecoration(
                  hintText: "Pesquisar",
                  hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                  icon: Icon(Icons.search,color: Theme.of(context).primaryColor,),
                  border: InputBorder.none
              ),
            onChanged: _userBloc.onChangedSearch,
            ),
        ),
        Expanded(
          child: StreamBuilder<List>(
            stream: _userBloc.outUsers,
            builder: (context, snapshot) {
              if(!snapshot.hasData)
                return Center(child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),),);
              else if(snapshot.data.length == 0)
                return Center(
                  child: Text("Nenhum usuário encontrado!",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor),
                  ),
                );
              else
                return ListView.separated(
                    itemBuilder: (context, index) {
                      return UserTile(snapshot.data[index]);
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: snapshot.data.length);
            }),
        ),

      ],
    );
  }
}
