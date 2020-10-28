import 'dart:convert';

import 'package:fluter_crud/data/dummy_users.dart';
import 'package:fluter_crud/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Users with ChangeNotifier {
  final String _baseUrl = 'https://app-armario.firebaseio.com/';

  final Map<String, User> _items = {...DUMMY_USERS};

  List<User> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  User byIndex(int i) {
    return _items.values.elementAt(i);
  }

  Future<void> put(User user) async {
    if (user == null) {
      return;
    }

    if (user.id != null &&
        user.id.trim().isNotEmpty &&
        _items.containsKey(user.id)) {
      await http.patch(
        "$_baseUrl/users/${user.id}.json",
        body: json.encode({
          'name': user.name,
          'email': user.email,
          'avatarUrl': user.avatarUrl,
        }),
      );

      _items.update(
        user.id,
        (_) => User(
          id: user.id,
          name: user.name,
          email: user.email,
          avatarUrl: user.avatarUrl,
        ),
      );
    } else {
      final response = await http.post(
        "$_baseUrl/users.json",
        body: json.encode({
          'name': user.name,
          'email': user.email,
          'avatarUrl': user.avatarUrl,
        }),
      );
      final id = json.decode(response.body)['name'];
      print(json.decode(response.body));
      _items.putIfAbsent(
        id,
        () => User(
          id: id,
          name: user.name,
          email: user.email,
          avatarUrl: user.avatarUrl,
        ),
      );
    }
    notifyListeners();
  }

  Future<void> remove(User user) async {
    if (user != null && user.id != null) {
      await http.delete("$_baseUrl/users/${user.id}.json");
      _items.remove(user.id);
      notifyListeners();
    }
  }
}
