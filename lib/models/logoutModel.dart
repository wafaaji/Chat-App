import 'dart:convert';

Logout LogoutFromJson(String str) => Logout.fromJson(json.decode(str));

class Logout {

  String? message;

  //constructor
  Logout({ this.message });

  //function for shift from json to object
  factory Logout.fromJson ( Map<String , dynamic> userJson) =>
      Logout(
        message: userJson['message'],
      );


}


