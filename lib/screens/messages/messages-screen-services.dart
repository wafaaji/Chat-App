import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:messanger/config/serverConfig.dart';
import 'package:messanger/models/ChatMessage.dart';
import 'package:messanger/models/ReceivedUser.dart';
import 'package:messanger/native-service/secureStorage.dart';
import 'dart:convert';

import 'package:messanger/screens/messages/message_screen.dart';

class MessageScreenService {

  //here the user id must be sent to the ui by the intialize it and
  //after that send it to the controller and service

  var url = Uri.parse('${ServerConfig.domainNameServer}${ServerConfig.messages}');

  void sendMessage(String message,bool isImageSelected) async {
    // Send the message to Laravel API
    // You need to implement this part.
    // Make an HTTP POST request to your Laravel API to send the message.
    // Update 'messages' when the message is successfully sent.


    SecureStorage storage = SecureStorage();
    var token = await storage.read("token");
    print(' i came here in services send message');
    if (!isImageSelected) {
      await http.post(
          url,
          headers: {
            'Authorization': 'Bearer $token'
          },
          body: {
            'user_id': MessagesScreen.otherUserId.toString(),
            'message': message
          }
      ).then((value) =>
          print(
              'this is the response of the send message ... ${value.statusCode}'
                  '... ${value.body}'));
    } else {
      var imageFile = File(message);
      http.MultipartRequest request = http.MultipartRequest('POST', url);
      request.headers.addAll(
          <String, String>{'Authorization': 'Bearer $token'});
      request.files.add(http.MultipartFile(
          'image', imageFile.readAsBytes().asStream(), imageFile.lengthSync(),
          filename: imageFile.path
              .split('/')
              .last));
      request.fields.addAll(<String,String> {'user_id': MessagesScreen.otherUserId.toString()});
      http.StreamedResponse response = await request.send();
      print('the returened data of image response ${response.statusCode}');
    }
  }

    Future<Map<String, dynamic>?> getMessages() async {
      SecureStorage storage = SecureStorage();
      var token = await storage.read("token");

      print('this is the conv id of this converstion is ${MessagesScreen
          .convId}');
      print('i got the get messages function');
      print(
          'here the value of convId inside services ${MessagesScreen.convId}');
      final url = Uri.parse('${ServerConfig.domainNameServer}${ServerConfig
          .chats}/${MessagesScreen.convId}${ServerConfig.messages}');

      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token'
      });

      // print('here is the body of the response of getting message ${response.body}');
      ReceivedUser? receivedUser;

      if (response.statusCode == 200) {
        final finalResponsedData = json.decode(response.body);

        List messageList = [];

        receivedUser = ReceivedUser(
            userId: finalResponsedData['conversation']['participants'][0]['id']
                .toString(),
            userName: finalResponsedData['conversation']['participants'][0]['name'],
            userEmail: finalResponsedData['conversation']['participants'][0]['email'],
            imageUrl: finalResponsedData['conversation']['participants'][0]['avatar_url']
        );

        // for(int i=0;i<15;i++){
        //   print(
        //     'this is the id of receiver ${finalResponsedData['messages']['data'][i]['user_id']}'
        //         'and this is the id of the sender (me) ${finalResponsedData['conversation']['user_id']}'
        //         'are they the same ? ${finalResponsedData['messages']['data'][i]['user_id']
        //     == finalResponsedData['conversation']['user_id']}'
        //   );
        // }

        //youuuuuu must ti handle the retuerned of images and voice
        messageList = finalResponsedData['messages']['data']
            .map(
              (value) =>
              ChatMessage(
                  messageType: value['type'] == 'text'
                      ? ChatMessageType.text
                      : ChatMessageType.image,
                  messageStatus: MessageStatus.viewed,
                  isSender: MessagesScreen.myId.toString() ==
                      value['user_id'].toString() ? true : false,
                  convId: finalResponsedData['conversation']['id'].toString(),
                  myId: finalResponsedData['conversation']['user_id']
                      .toString(),
                  body: value['body'],
                  messageId: value['id'].toString()
              ),
        ).toList();

        // for(int i=0;i<messageList.length;i++){
        //   print(
        //       'this is the check if i am sender or not'
        //           ' ${messageList[i].isSender}'
        //   );
        // }
        // // print('saved successed ${message}');
        // print('the size of messageList is in services is ${messageList.length}');
        // print('the value of received user is ${receivedUser}');

        return {
          'messageList': messageList,
          'receivedUser': receivedUser
        };
        // print('this is final response data conversation after being json decoded ${finalResponsedData['conversation']}');

      }
      return null;
    }

  }
