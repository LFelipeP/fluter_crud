import 'package:fluter_crud/components/user_tile.dart';
import 'package:fluter_crud/models/user.dart';

import 'package:fluter_crud/routes/app_routes.dart';
import 'package:fluter_crud/utils/User_api.dart';

import 'package:flutter/material.dart';

class UserList extends StatelessWidget {
  Future<void> _refreshUsers(BuildContext context) {
    return Navigator.of(context).popAndPushNamed(
      AppRoutes.HOME,
    );
  }

  @override
  Widget build(BuildContext context) {
    //final Users usersData = Provider.of(context);
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
        child: teste(),
      ),
    );
  }

  teste() {
    Future<List<User>> future = UserApi.getUser();
    print("future");
    print(future);
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return Center(child: Text("Erro ao carregar banco de dados"));
        }
        if (!snapshot.hasData) {
          print(snapshot.error);
          print(snapshot.data);
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<User> users = snapshot.data;
        return _listView(users);
      },
    );
  }

  Container _listView(List<User> users) {
    return Container(
      child: ListView.builder(
        itemCount: users != null ? users.length : 0,
        itemBuilder: (ctx, i) {
          User u = users[i];
          return UserTile(u);
        },
      ),
    );
  }
}
//RefreshIndicator( onRefresh: () => _refreshUsers(context),child:
//itemBuilder: (ctx, i) => UserTile(usersData.byIndex(i),
