import 'package:get/get.dart';
import 'package:messanger/models/ChatMessage.dart';
import 'package:messanger/models/ReceivedUser.dart';
import 'package:messanger/models/chatsModel.dart';
import 'package:messanger/native-service/secureStorage.dart';
import 'package:messanger/screens/chats/chats-services.dart';
import 'package:messanger/screens/chats/logout-services.dart';
import 'package:messanger/screens/messages/message_screen.dart';
import 'package:messanger/screens/messages/messages-screen-services.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class ChatsController extends GetxController {

  var message;
  final PusherChannelsFlutter pusherChannels = PusherChannelsFlutter.getInstance();

  late ChatsService serviceDisplay;
  RxList chatsList = <Chat>[].obs;
  late List<Chat> allChats= [];

  var isLoading = true.obs;
  SecureStorage storage = SecureStorage();

  late LogoutService service;
  late MessageScreenService messagesService ;
  var logoutStatus;
  // String whereWe = "messages";
  var messages = [].obs;
  Rx<ReceivedUser> receivedUser = ReceivedUser(userId: '',
      userName: '',
      userEmail: '',
      imageUrl: '').obs;
  List<RxBool> isRead = [];

  @override
  void onInit() async{
    serviceDisplay = ChatsService();

    service = LogoutService();
    logoutStatus = false;
    message = '';
    messagesService = MessageScreenService();

    await fetchData();
    print('this is before sunscribing and myId is ${MessagesScreen.myId}');

    try{

      await pusherChannels.init(
          apiKey: "29e528a015ea6d3eb55d",
          cluster: 'ap2',

          onConnectionStateChange: (current,prev)=>{onConnectionStateChange(current)},
          onError: (message,hey,error)=>{
            // print('this is the messgae ${messages.toString()} and this is the error $error ')
          }
      ).then((value) => print('the value refer to there is no error}'));

      print('pusher connection ${pusherChannels.connectionState}');

      await pusherChannels.connect().then((value) => print('it is successed yes'));

      //here you must cross the parameters users id that must to listen when the controller
      //is intialized for them
      //call the function that listen to multiple channels
      await subscribeToChannels();

      print('pusher connection ${pusherChannels.connectionState}');

    }catch(e){
      print("ERROR inside try: $e");
    }

    super.onInit();
  }


  Future<void> subscribeToChannels() async {

    //this will stay as it because the static variables will take the right values
    final channelMessagesNames = [
      'Messenger.${MessagesScreen.myId.toString()}',
      'Messenger.${MessagesScreen.otherUserId.toString()}'
    ];

    print('what are the channels name here ${MessagesScreen.myId.toString()}'
        '${MessagesScreen.otherUserId.toString()}');

    //here there was a problem of this you are reading int mayble String? i do not know
    // final String? myId = await storage.read('myId');

    print('what is the bool value of it ?${pusherChannels.channels.containsKey(channelMessagesNames[0])}');

    //and here must get only the id if mine because just me should see the chats of me
    // final channelChatsNames = ['Messenger.${myId?? ''}'];

    print('what are the channels name here ${MessagesScreen.myId.toString()}');

    // print('this is the value of whereWe before get inside the condition $whereWe');

    //here the condition to listen you can listen only if you checked up(verified) the condition
    // if(whereWe == 'messages'){
      //you must to update the message screen and the chats screen

    print('the size of channelMessagesNames ${channelMessagesNames.length}');
      for (final channelName in channelMessagesNames) {
        print('this is before event without subscribing');
        if(!pusherChannels.channels.containsKey(channelName)) {
          await pusherChannels.subscribe(
            channelName: channelName,
            onEvent: (event) {
              print('this is the event $event');
              print('woooowwowow');
              // receiveMessages();
            },
            onSubscriptionError: (error) {
              print('error in subscribing to the channel $channelName: $error');
            },
          );
          // fetchData();
        }

          pusherChannels.onEvent = ((event){
            print('must to be called out of the if in subscribe function!!');
            receiveMessages();
            fetchData();
          });
      }
    // }else{
      //you must to update the the chats screen only
    //   for (final channelName in channelChatsNames) {
    //     if(!pusherChannels.channels.containsKey(channelName))
    //     {
    //       await pusherChannels.subscribe(
    //         channelName: channelName,
    //         onEvent: (event) {
    //           print('this is the event $event');
    //           print('woooowwowow');
    //           receiveMessages();
    //         },
    //         onSubscriptionError: (error) {
    //           print('error in subscribing to the channel $channelName: $error');
    //         },
    //       );
    //     }
    //     fetchData();
    //
    //   }
    // }

  }


  Future<ChatMessage?> receiveMessages() async {
    Map<String,dynamic>? messageMap = await messagesService.getMessages();
    List? message = [];
    if(messageMap?['messageList'] != null){
      print('yes i got messageList');
      message = messageMap!['messageList'];
      print('the value of received user in controller is ${messageMap['receivedUser']}');

      receivedUser.value = ReceivedUser(userId: messageMap['receivedUser'].userId,
          userName: messageMap['receivedUser'].userName,
          userEmail: messageMap['receivedUser'].userEmail,
          imageUrl: messageMap['receivedUser'].imageUrl);
      print('after editing the receivedUserin controller its value became is ${receivedUser.value}');
    }
    if(message !=null){
      messages.value.clear();
      print('the size of message got is ${message.length}');
      messages.value = message.map((element) =>
          ChatMessage(messageType: element.messageType
              , messageStatus: element.messageStatus,
              isSender: element.isSender, convId: element.convId,
              myId: element.myId,
              body: element.body,
              messageId: element.messageId
          )
      ).toList().obs;
    }
    print('this is the messages list after imp function ${messages.length}');
    return null;
  }

  void onConnectionStateChange(change) {
    print('Connection state changed: ${change.currentState}');

    // if (change.currentState == ConnectionState.CONNECTED) {
    //   print('Pusher connection successful!');
    // } else if (change.currentState == ConnectionState.DISCONNECTED) {
    //   print('Pusher connection failed!');
    // }
  }


  @override
  void onReady() async{

    var token = await storage.read("token");
    allChats = await serviceDisplay.displayChats(token);
    chatsList.value = allChats;
    isLoading.value = false;

    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    print('i closed the chats controller');
    //here must to close the pusher connection.
  }

  Future<void> fetchData() async {
    isLoading.value = true;

    var token = await storage.read("token");
    allChats = await serviceDisplay.displayChats(token);
    isRead = allChats.map((e) => e.newMessages == 0 ? RxBool(true) : RxBool(false)).toList();
    chatsList.value = allChats;
    isLoading.value = false;

  }

  Future<void> logoutOnClick() async{
    String? token = await storage.read("token");
    print("______________logout________________");
    print(token);
    logoutStatus = await service.logout(token);
    message = service.message;

    if (message is List) {
      String temp = '';
      for (String s in message) {
        temp += "$s\n";
      }
      message = temp;
    }
  }

  void readChatMessages(String convId,int chatIndex) async {

    String? token = await storage.read("token");
    bool readStatus = await serviceDisplay.readChatMessages(convId, token);

    if(readStatus) {
      isRead[chatIndex].value = true;
    }
  }



}
