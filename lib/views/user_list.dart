import 'package:fluter_crud/components/user_tile.dart';
import 'package:fluter_crud/provider/users.dart';
import 'package:fluter_crud/routes/app_routes.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  Future<void> _refreshUsers(BuildContext context) {
    return Provider.of<Users>(context, listen: false).loadUser();
  }

  @override
  Widget build(BuildContext context) {
    final Users usersData = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Usuários'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.USER_FORM,
              );
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshUsers(context),
        child: ListView.builder(
          itemCount: usersData.itemsCount,
          itemBuilder: (ctx, i) => UserTile(
            usersData.byIndex(i),
          ),
        ),
      ),
    );
  }
}
