import 'dart:convert';
import 'dart:convert' as convert;

import 'package:fluter_crud/models/user.dart';
import 'package:fluter_crud/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Users with ChangeNotifier {
  final String _baseUrl = '${Constants.BASE_API_URL}/users';
  List<User> _items = [];

  List<User> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  User byIndex(int i) {
    return _items.elementAt(i);
  }

  static Future<List<User>> getUser() async {
    try {
      final String _baseUrl = '${Constants.BASE_API_URL}/users';
      var response = await http.get(_baseUrl);
      String json = response.body;
      List list = convert.json.decode(json);
      final user = List<User>();
      for (Map map in list) {
        User c = User.fromJson(map);
        user.add(c);
      }
      return [];
    } catch (error) {
      print(error);
    }
  }
  //List<User> get favoriteItems {
  //return _items.where((prod) => prod.isFavorite).toList();
  //}

  Future<void> loadUser() async {
    final response = await http.get("$_baseUrl.json");
    Map<String, dynamic> data = json.decode(response.body);

    _items.clear();
    if (data != null) {
      data.forEach((userId, userData) {
        _items.add(User(
          id: userId,
          name: userData['name'],
          email: userData['email'],
          avatarUrl: userData['avatarUrl'],
        ));
      });
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> addUser(User user) async {
    final response = await http.post(
      "$_baseUrl.json",
      body: json.encode({
        'name': user.name,
        'email': user.email,
        'avatarUrl': user.avatarUrl,
      }),
    );

    _items.add(User(
      id: json.decode(response.body)['name'],
      name: user.name,
      email: user.email,
      avatarUrl: user.avatarUrl,
    ));
    notifyListeners();
  }

  Future<void> updateUser(User user) async {
    if (User == null || user.id == null) {
      return;
    }

    final index = _items.indexWhere((use) => use.id == user.id);
    if (index >= 0) {
      await http.patch(
        "$_baseUrl/${user.id}.json",
        body: json.encode({
          'id': user.id,
          'name': user.name,
          'email': user.email,
          'avatarUrl': user.avatarUrl,
        }),
      );
      _items[index] = user;
      notifyListeners();
    }
  }

  Future<void> deleteUser(user) async {
    if (user != null && user.id != null) {
      await http.delete("$_baseUrl/users/${user.id}.json");
      notifyListeners();
    }
  }
}

/*class Users with ChangeNotifier {
  final String _baseUrl = 'https://app-armario.firebaseio.com/';
  Map<String, User> _items = {};

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
}*/
