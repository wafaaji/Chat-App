import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messanger/constants.dart';
import 'package:messanger/screens/chats/chats-controller.dart';
import 'components/body.dart';

class MessagesScreen extends StatelessWidget {
  static var convId;
  static var myId;
  static var otherUserId;

   const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('builded builded ');
    print('this is the multiple values of conId ${MessagesScreen.convId}');
    print('this is the multiple values of myId ${MessagesScreen.myId}');
    print('this is the multiple values of otherId ${MessagesScreen.otherUserId}');

    return Scaffold(
      appBar: buildAppBar(),
      body: const Body(),
    );
  }

  AppBar buildAppBar() {

    final ChatsController chatsScreenController = Get.put(ChatsController());

    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          const BackButton(),
          CircleAvatar(
            backgroundImage: chatsScreenController.receivedUser.value.userName == '' ?
              const NetworkImage("assets/images/user_2.png") : NetworkImage(
                chatsScreenController.receivedUser.value.imageUrl.toString()
            ),
          ),
          const SizedBox(width: kDefaultPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
               Obx(
              ()=> Text(
                    chatsScreenController.receivedUser.value.userName != '' ?
                    chatsScreenController.receivedUser.value.userName : "",
                    style: const TextStyle(fontSize: 16),
                  ),
               ),

              const Text(
                "Active",
                style: TextStyle(fontSize: 12),
              )
            ],
          )
        ],
      ),
    );
  }
}
