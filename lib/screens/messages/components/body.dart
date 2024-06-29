import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messanger/constants.dart';
import 'package:messanger/screens/chats/chats-controller.dart';
import 'chat_input_field.dart';
import 'message.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ChatsController chatsScreenController = Get.put(ChatsController());
    // final myLastChatsController = Get.find<ChatsController>();
    chatsScreenController.receiveMessages();
    // myLastChatsController.channelMessagesNames.map((e) =>
    //     myLastChatsController.pusherChannels.unsubscribe(channelName: e));

        // controller.subscribeToChannels();

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Obx(
            ()=> ListView.builder(
              reverse: true,
                itemCount: chatsScreenController.messages.length,
                itemBuilder: (context, index) =>
                    Message(message: chatsScreenController.messages[index]),
              ),
            ),
          ),
        ),
        const ChatInputField(),
      ],
    );
  }
}
