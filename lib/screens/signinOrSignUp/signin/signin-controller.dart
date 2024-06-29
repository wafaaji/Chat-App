import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messanger/models/signinModel.dart';
import 'package:messanger/screens/signinOrSignUp/signin/signin-services.dart';

class SigninController extends GetxController {

  final signinFormKey = GlobalKey<FormState>();
  late TextEditingController emailController , passwordController;
  var email = '';
  var password = '';
  RxBool isPassword = true.obs;

  //for signin
  late SigninService service;
  var signinStatus;
  var message;

  @override
  void onInit(){
    emailController = TextEditingController();
    passwordController = TextEditingController();

    service = SigninService();
    signinStatus = false;
    message = '';

    super.onInit() ;
  }


  @override
  void onClose(){
    super.onClose();

    emailController.dispose();
    passwordController.dispose();
  }

  String? validateEmail (String value)
  {
    if (!GetUtils.isEmail(value))
    {
      return 'Please provide valid Email';
    }
    return null;
  }

  String? validatePassword (String value)
  {
    if (value.length < 8)
    {
      return 'Password must be of 8 characters';
    }
    return null;
  }


  void changePassword (){
    isPassword.value = !isPassword.value;
    update();
  }

  Future<void> signinOnClick() async{
    email = emailController.text;
    password = passwordController.text;
    Signin signin = Signin(
      email: email,
      password: password,
    );
    print("______________signin________________");
    signinStatus = await service.signin(signin);

    // if (signinStatus) {
    //   message = "Login successful";
    // } else {
    //   message = service.message;
    //
    //   if (message is List) {
    //     String temp = '';
    //     for (String s in message)
    //       temp += s + "\n";
    //     message = temp;
    //   }
    // }

  }

}