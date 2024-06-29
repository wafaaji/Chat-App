import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:messanger/constants.dart';
import 'package:messanger/screens/chats/chats-controller.dart';
import 'package:messanger/screens/welcome/welcome_screen.dart';
import 'components/body.dart';

class ChatsScreen extends GetView<ChatsController> {
  const ChatsScreen({super.key});


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: buildAppBar(),
      body: const Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      automaticallyImplyLeading: false,
      title: const Text("Chats"),
      actions: [
       IconButton(
         icon:  const Icon(
           Icons.logout,
           size: 30.0,
         ),
         onPressed: (){
           onClickLogout();
         },
       ),
    ],
    );
  }

  void onClickLogout() async{
    EasyLoading.show(status: "loading...");

    await controller.logoutOnClick();

    if(controller.logoutStatus){
      EasyLoading.showSuccess(
        controller.message,
        duration: const Duration(seconds: 5),
        dismissOnTap: true,
        maskType: EasyLoadingMaskType.black,
      );
      Get.to( () => const WelcomeScreen());
    }else{
      EasyLoading.showError(
        controller.message,
        duration: const Duration(seconds: 5),
        dismissOnTap: true,
        maskType: EasyLoadingMaskType.black,
      );
      print("Error Here");
    }
  }
}
