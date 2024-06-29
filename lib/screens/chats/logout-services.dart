import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:messanger/config/serverConfig.dart';
import 'package:messanger/native-service/secureStorage.dart';

class LogoutService {

  var message;

  var url = Uri.parse(ServerConfig.domainNameServer + ServerConfig.logout);

  Future<bool> logout(var token) async{
    try {
      var response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        //take json and make it var
        var jsonResponse = jsonDecode(response.body);
        message = jsonResponse["message"];
        SecureStorage storage = SecureStorage();
        await storage.delete("token");
        return true;
      } else {
        message = 'Server Error';
        return false;
      }
    } catch (e) {
      // Handle the exception here (e.g., print error message)
      print("Exception during logout request: $e");
      message = 'An error occurred';
      return false;
    }

  }

}