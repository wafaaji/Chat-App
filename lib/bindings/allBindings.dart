import 'package:messanger/screens/chats/chats-controller.dart';
import 'package:messanger/screens/signinOrSignUp/signin/signin-controller.dart';
import 'package:messanger/screens/welcome/welcome-controller.dart';
import 'package:get/get.dart';

class allBindings extends Bindings {

  @override
  void dependencies() {

    Get.lazyPut(() => SigninController());
    Get.lazyPut(() => WelcomeController());
    Get.lazyPut(() => ChatsController());
  }
}