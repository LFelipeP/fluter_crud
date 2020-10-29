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

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      avatarUrl: json['avatarUrl'],
      email: json['email'],
    );
  }

  User.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatarUrl = json['avatarUrl'];
    email = json['email'];
  }

  Map<String, User> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['avatarUrl'] = this.avatarUrl;
    return data;
  }
}
