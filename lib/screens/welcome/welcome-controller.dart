import 'package:get/get.dart';
import 'package:messanger/native-service/secureStorage.dart';

class WelcomeController extends GetxController {
  late SecureStorage storage;

  @override
  void onInit() async {
    super.onInit();
    print("aaa");

    storage = SecureStorage();
    // await storage.save('token', null);

    print("bbb");
  }
}
