import 'package:http/http.dart' as http;
import 'package:messanger/config/serverConfig.dart';
import 'package:messanger/models/chatsModel.dart';
import 'package:messanger/screens/messages/message_screen.dart';

class ChatsService {

  var message;

  Future<List<Chat>> displayChats(var token) async{

    var url = Uri.parse(ServerConfig.domainNameServer + ServerConfig.chats);

    try {
      var response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      print(response.statusCode);
      print('this is the body of all chats ${response.body}'
          '${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        //take json and make it var
        //var chats = chatsFromJson(response.body);
        //var jsonResponse = jsonDecode(response.body);
        var chatsList = chatsFromJson(response.body);

        //here i will start saving my id and when click some conversation container
        //we will listen to it channel also
        // and in this way i will start listen from start to the channel of the user

        MessagesScreen.myId = chatsList.myId;
        print('this is the my id after loading the chats screen ${MessagesScreen.myId}');
        return chatsList.chats;
      } else {
        message = 'Server Error';
        return [];
      }
    } catch (e) {
      print("Exception during request: $e");
      message = 'An error occurred';
      return [];
    }

  }

  Future<bool> readChatMessages(String convId,String? token) async {

    var url = Uri.parse('${ServerConfig.domainNameServer}${ServerConfig.chats}/$convId${ServerConfig.read}');

    var response = await http.put(url,headers: {
      "Authorization": "Bearer $token",
    });

    return (response.statusCode == 200);
  }


}