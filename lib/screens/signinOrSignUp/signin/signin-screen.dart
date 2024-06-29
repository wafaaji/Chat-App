import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messanger/components/custom-elevated-button.dart';
import 'package:messanger/components/custom-text-field.dart';
import 'package:messanger/constants.dart';
import 'package:messanger/screens/chats/chats_screen.dart';
import 'package:messanger/screens/signinOrSignUp/signin/signin-controller.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SigninScreen extends GetView<SigninController> {
  const SigninScreen({super.key});


  @override
  Widget build(BuildContext context) {

    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Theme(
        data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSwatch().copyWith(secondary: kPrimaryColor,)
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: height * 0.12,
                width: width,
                color: kPrimaryColor,
              ),
              Container(
                height: height * 0.88,
                width: width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(25.0,),topLeft: Radius.circular(25.0,)),
                  color: Colors.white,
                ),
                child:Form(
                  key: controller.signinFormKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                      children: [
                        const SizedBox(
                          height: 40.0,
                        ),
                        const Text(
                          'SING IN',
                          style: TextStyle(
                            fontSize: 35.0,
                            color: kPrimaryColor,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,),
                        const Text(
                          'Lets sign in to your account',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Color(0xFFD9D9D9),
                          ),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        SizedBox(
                          width: 250.0,
                          height: 50.0,
                          child: CustomTextField(
                            controller: controller.emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction : TextInputAction.next,
                            onSaved: (value) {
                              controller.email = value!;
                            },
                            validator: (value) {
                              return controller.validateEmail(value!);
                            },
                            decoration: InputDecoration(
                              hintText: 'Email Address',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(
                                  color: kPrimaryColor,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),

                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          width: 250.0,
                          height: 50.0,
                          child: Obx(()=> CustomTextField(
                            controller: controller.passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: controller.isPassword.value,
                            onSaved: (value) {
                              controller.password = value!;
                            },
                            validator: (value) {
                              return controller.validatePassword(value!);
                            },
                            decoration: InputDecoration(
                              hintText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.isPassword.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: kPrimaryColor,
                                ),
                                onPressed: () {
                                  controller.changePassword();
                                },
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(
                                  color: kPrimaryColor,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                          ),
                          ),
                        ),
                        const SizedBox(
                          height: 90.0,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        CustomElevatedButton(
                          onPressed: () {
                            onClickSignin();
                          },
                          buttonText: 'signin',
                          buttonColor: kPrimaryColor,
                          borderRadius: BorderRadius.circular(20),
                          height: 50.0,
                          fontSize: 18.0,
                          textColor: Colors.white,
                        ),
                      ]
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onClickSignin() async{
    EasyLoading.show(status: "loading...");

    await controller.signinOnClick();

    if(controller.signinStatus){
      EasyLoading.showSuccess(
        //controller.message,
        'Signin successful',
        duration: const Duration(seconds: 5),
        dismissOnTap: true,
        maskType: EasyLoadingMaskType.black,
      );
      Get.to(() => const ChatsScreen());
    }else{
      EasyLoading.showError(
        //controller.message,
        'incorrect username or password',
        duration: const Duration(seconds: 5),
        dismissOnTap: true,
        maskType: EasyLoadingMaskType.black,
      );
      print("Error Here");
    }
  }

}