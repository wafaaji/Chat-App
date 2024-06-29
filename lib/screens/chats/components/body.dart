import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:messanger/constants.dart';
import 'package:messanger/screens/chats/chats-controller.dart';
import 'package:messanger/screens/messages/message_screen.dart';

import 'chat_card.dart';

class Body extends GetView<ChatsController> {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx( (){
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator(color: kPrimaryColor,));
      }
      return RefreshIndicator(
        onRefresh: controller.fetchData,
        color: kPrimaryColor,
        child: Column(
          children: [
            // Container(
            //   padding: const EdgeInsets.fromLTRB(
            //       kDefaultPadding, 0, kDefaultPadding, kDefaultPadding),
            //   color: kPrimaryColor,
            //   child: Row(
            //     children: [
            //       FillOutlineButton(press: () {}, text: "Recent Message"),
            //       const SizedBox(width: kDefaultPadding),
            //       FillOutlineButton(
            //         press: () {},
            //         text: "Active",
            //         isFilled: false,
            //       ),
            //     ],
            //   ),
            // ),
            Expanded(
              child: ListView.builder(
                itemCount: controller.allChats.length,
                itemBuilder: (context, index)
                {
                  final chats = controller.allChats[index];

                  return  ChatCard(
                  chat: chats,
                  chatIndex: index,
                  press: () => {
                    MessagesScreen.convId = chats.id,//here to change later
                    controller.readChatMessages(chats.id.toString(),index),
                    // MessagesScreen.myId = chats.userId,//here to change later
                    MessagesScreen.otherUserId = chats.participants[0].id,
                    print('this is the my user id after saving${MessagesScreen.myId}'),
                    print('this is the other user id after saving${chats.participants[0].id}'),
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MessagesScreen(),
                      ),
                    ),

                  }
                );
               }
              ),
            ),
          ],
        ),
      );
    }
    );
  }
}
