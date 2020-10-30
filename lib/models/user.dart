import 'package:flutter/material.dart';

class User {
  String id;
  String name;
  String email;
  String avatarUrl;

  User({
    this.id,
    @required this.name,
    @required this.email,
    @required this.avatarUrl,
  });

  factory User.fromJsogn(Map<String, dynamic> json, var mapUser, int i) {
    print(json.keys.elementAt(i));
    return User(
      id: json.keys.elementAt(i),
      name: mapUser.values.elementAt(2),
      avatarUrl: mapUser.values.elementAt(0),
      email: mapUser.values.elementAt(1),
    );
  }

  User.fromJson(Map<String, dynamic> json) {
    //id = json['id'];
    name = json['name'];
    avatarUrl = json['avatarUrl'];
    email = json['email'];
  }

  Map<String, User> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['avatarUrl'] = this.avatarUrl;
    return data;
  }
}
