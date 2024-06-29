import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:messanger/config/serverConfig.dart';
import 'package:messanger/models/signinModel.dart';
import 'package:messanger/native-service/secureStorage.dart';

class SigninService {

  var message;
  var token;

  var url = Uri.parse(ServerConfig.domainNameServer + ServerConfig.signin);

  Future<bool> signin(Signin signin) async{
    print("Email: ${signin.email}");
    print("Password: ${signin.password}");
    try {
      final response = await http.post(
        url,
        headers: {},
        body: {
          "email": signin.email,
          "password": signin.password,
        },
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {

        //take json and make it var
        var jsonResponse = jsonDecode(response.body);
        token = jsonResponse["token"];
        SecureStorage storage = SecureStorage();
        await storage.save("token", token);
        //here to save my id for using it in another places.
        // await storage.save('myId',jsonResponse['user']['id']);

        return true;
      } else if (response.statusCode == 401) {
        var jsonResponse = jsonDecode(response.body);
        message = jsonResponse["msg"];
        return false;
      } else {
        message = 'Server Error';
        return false;
      }
    }catch(e){
      print('Exception: $e');
      return false;
    }

  }

}