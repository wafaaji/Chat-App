import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messanger/constants.dart';
import 'package:messanger/screens/chats/chats-controller.dart';
import 'package:messanger/screens/chats/chats_screen.dart';
import 'package:messanger/screens/signinOrSignUp/signin/signin-controller.dart';
import 'package:messanger/screens/signinOrSignUp/signin/signin-screen.dart';
import 'package:messanger/screens/welcome/welcome-controller.dart';

class WelcomeScreen extends GetView<WelcomeController> {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),
            Image.asset("assets/images/welcome_image.png"),
            const Spacer(flex: 3),
            Text(
              "Welcome to our freedom \nmessaging app",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Text(
              "Freedom talk any person of your \nmother language.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .color!
                    .withOpacity(0.64),
              ),
            ),
            const Spacer(flex: 3),
            FittedBox(
              child: TextButton(
                  onPressed: () async{
                      String? token = await controller.storage.read("token");
                      if (token != null) {
                        //here i must define or intialize the controller in each
                        //time just for make the screen is listening for the channel
                        //and subscribing all the chnages occured and update depend on it
                        Get.lazyPut(() => ChatsController());
                        Get.to(()=> const ChatsScreen());
                      } else {
                        Get.lazyPut(() => SigninController());
                        Get.to(()=> const SigninScreen());
                        }
                    },
                  child: Row(
                    children: [
                      Text(
                        "Skip",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .color!
                                  .withOpacity(0.8),
                            ),
                      ),
                      const SizedBox(width: kDefaultPadding / 4),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .color!
                            .withOpacity(0.8),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
