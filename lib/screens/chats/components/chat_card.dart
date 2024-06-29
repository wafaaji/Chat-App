import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messanger/models/chatsModel.dart';
import 'package:messanger/screens/chats/chats-controller.dart';
import '../../../constants.dart';

class ChatCard extends GetView<ChatsController> {
  const ChatCard({
    Key? key,
    required this.chat,
    required this.chatIndex,
    required this.press,
  }) : super(key: key);

  final Chat chat;
  final VoidCallback press;
  final int chatIndex;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: kDefaultPadding * 0.75),
        child:
        Obx(
          ()=>
              Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 24,
                    //backgroundImage: AssetImage('assets/images/user.png'),
                    backgroundImage: NetworkImage(chat.participants.first.avatarUrl,),
                  ),
                  // if (true)
                  //   Positioned(
                  //     right: 0,
                  //     bottom: 0,
                  //     child: Container(
                  //       height: 16,
                  //       width: 16,
                  //       decoration: BoxDecoration(
                  //         color: kPrimaryColor,
                  //         shape: BoxShape.circle,
                  //         border: Border.all(
                  //             color: Theme.of(context).scaffoldBackgroundColor,
                  //             width: 3),
                  //       ),
                  //     ),
                  //   )
                ],
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chat.participants.first.name,
                        style:
                            const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      !controller.isRead[chatIndex].value
                       ? Text(
                          chat.lastMessage.body,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ) : Text(
                        chat.lastMessage.body,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              !controller.isRead[chatIndex].value
                  ? Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: kPrimaryColor,
                ),
                child: Text(
                  chat.newMessages.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ) : Container()
            ],
          ),
        ),
      ),
    );
  }
}
