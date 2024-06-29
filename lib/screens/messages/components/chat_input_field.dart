import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messanger/screens/messages/messages-screen-controller.dart';

import '../../../constants.dart';

class ChatInputField extends StatelessWidget {

  const ChatInputField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MessageScreenController messageScreenController = Get.put(MessageScreenController());
    String? textValue = "null";
    final TextEditingController textEditor = TextEditingController();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 32,
            color: const Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            const SizedBox(width: kDefaultPadding),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding * 0.75,
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Obx(
                    ()=> Row(
                    children: [
                      const SizedBox(width: kDefaultPadding / 4),
                       Expanded(
                        child: TextField(
                          controller: textEditor,
                          onChanged: (value){
                            print("the value inside textfield is $value");
                            textValue = value;
                          },
                          enabled: !messageScreenController.isImageSelected.value, // disable text field when image is selected
                          decoration: const InputDecoration(
                            hintText: "Type message",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      !messageScreenController.isImageSelected.value ? GestureDetector(
                        onTap: () {
                          messageScreenController.pickImageGallery();
                        },
                        child: Icon(
                          Icons.image,
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(0.64),
                        ),
                      ) : GestureDetector(
                        onTap: () {
                          messageScreenController.deleteImageSelected(); // remove the image selection
                        },
                        child: Icon(
                          Icons.delete,
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(0.64),
                        ),
                      ),  // render an empty SizedBox when image is selected
                      const SizedBox(width: kDefaultPadding / 4),
                      !messageScreenController.isImageSelected.value ? GestureDetector(
                        onTap: () {
                          messageScreenController.pickImageCamera();
                        },
                        child: Icon(
                          Icons.camera_alt,
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(0.64),
                        ),
                      ) : GestureDetector(
                        onTap: () {
                          messageScreenController.deleteImageSelected(); // remove the image selection
                        },
                        child: Icon(
                          Icons.delete,
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(0.64),
                        ),
                      ),

                    ],
                  ),
                ),

              ),

            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: (){
                messageScreenController.isImageSelected.value ?
                messageScreenController.sendMessage(messageScreenController.imagePath.value) :
                messageScreenController.sendMessage(textValue);
                textEditor.clear();
              },
              child: const Icon(
                Icons.send,
                color: kPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
