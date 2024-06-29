import 'dart:convert';

import 'package:messanger/models/user.dart';

Signin SigninFromJson(String str) => Signin.fromJson(json.decode(str));

String SigninToJson(Signin data) => json.encode(data.toJson());

class Signin {
  User? user;
  String? token;
  String? message;
  String? email;
  String? password;

  Signin({
    this.user,
    this.token,
    this.message,
    this.email,
    this.password,
  });

  factory Signin.fromJson(Map<String, dynamic> json) => Signin(
    user: User.fromJson(json["user"]),
    token: json["token"],
    message: json['msg'],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
  };
}
