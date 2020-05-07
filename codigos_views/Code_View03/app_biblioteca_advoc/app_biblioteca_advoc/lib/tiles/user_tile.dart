import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {

  final Map<String, dynamic> user;

  UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        user["name"],
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      subtitle: Text(
        user["email"],
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            "Pedidos: ${user["orders"]}",
            style: TextStyle(color: Theme.of(context).primaryColor),),
          Text(
            "Devoluções: 0",
            style: TextStyle(color: Theme.of(context).primaryColor),),
        ],
      ),
    );
  }
}
