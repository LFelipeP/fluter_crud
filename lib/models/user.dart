import 'package:flutter/material.dart';

class User {
  String id;
  String name;
  String email;
  String avatarUrl;
  String senha;
  String validade;
  String armario;

  User({
    this.id,
    @required this.senha,
    @required this.validade,
    @required this.armario,
    @required this.name,
    @required this.email,
    @required this.avatarUrl,
  });

  factory User.fromJsogn(Map<String, dynamic> json, var mapUser, int i) {
    print(json.keys.elementAt(i));
    return User(
      id: json.keys.elementAt(i),
      name: mapUser.values.elementAt(3),
      avatarUrl: mapUser.values.elementAt(1),
      email: mapUser.values.elementAt(2),
      validade: mapUser.values.elementAt(5),
      armario: mapUser.values.elementAt(0),
      senha: mapUser.values.elementAt(4),
    );
  }
}
