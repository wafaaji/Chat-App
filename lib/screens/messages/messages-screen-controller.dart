import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messanger/screens/chats/chats-controller.dart';
import '../../screens/messages/messages-screen-services.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class MessageScreenController extends GetxController {

  final PusherChannelsFlutter pusherChannels = PusherChannelsFlutter.getInstance();
  //for image
  RxString imagePath = ''.obs;
  MessageScreenService service = MessageScreenService();
  RxBool isImageSelected = false.obs;

  @override
  void onInit() async{

  }


  void sendMessage(message) async {

    //this message should be on of the two types either image or text.
    //that depending on the imagePath value in the controller if it is true message
    //should be image either must be text
    //care here there is no care for knowing what are the type of the message just send it and the need
    //is on the service .
    //so here the sendMessage function for the service must be know if the isSelected image or not

    service.sendMessage(message,isImageSelected.value);
    // await subscribeToChannels();
    final myLastChatsController = Get.find<ChatsController>();
    await myLastChatsController.subscribeToChannels();

  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    print('look here i disposed or closed the message screen controller when i click'
        'the back buttom that is default in the mobile');

    //
  }

  //for send image
  Future<void> pickImageGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path; // Update imagePath
      print('image is ${imagePath.value}');
      isImageSelected.value = true;
    }
  }

  Future<void> pickImageCamera() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path; // Update imagePath
      print('camera is ${imagePath.value}');
      isImageSelected.value = true;
    }
  }

  void deleteImageSelected(){
    imagePath.value = '';
    isImageSelected.value = false;
    print('after selecting the delete button imageSelected is $isImageSelected and imagePath is $imagePath');
  }
//

}