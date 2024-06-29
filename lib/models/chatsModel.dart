import 'dart:convert';

Chats chatsFromJson(String str) => Chats.fromJson(json.decode(str));

String chatsToJson(Chats data) => json.encode(data.toJson());

class Chats {
  int myId = 1;
  List<Chat> chats;

  Chats({
    required this.chats,
  });

  factory Chats.fromJson(Map<String, dynamic> json) => Chats(
    chats: List<Chat>.from(json["conversations"]["data"].map((x) => Chat.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(chats.map((x) => x.toJson())),
  };
}


class Chat {
  int id;
  int userId;
  dynamic label;
  String type;
  DateTime createdAt;
  DateTime updatedAt;
  int lastMessageId;
  int newMessages;
  LastMessage lastMessage;
  List<Participant> participants;

  Chat({
    required this.id,
    required this.userId,
    required this.label,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.lastMessageId,
    required this.newMessages,
    required this.lastMessage,
    required this.participants,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
    id: json["id"],
    userId: json["user_id"],
    label: json["label"],
    type: json["type"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    lastMessageId: json["last_message_id"],
    newMessages: json["new_messages"],
    lastMessage: LastMessage.fromJson(json["last_message"]),
    participants: List<Participant>.from(json["participants"].map((x) => Participant.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "label": label,
    "type": type,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "last_message_id": lastMessageId,
    "new_messages": newMessages,
    "last_message": lastMessage.toJson(),
    "participants": List<dynamic>.from(participants.map((x) => x.toJson())),
  };
}

class LastMessage {
  int id;
  int conversationId;
  int userId;
  String body;
  String type;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  LastMessage({
    required this.id,
    required this.conversationId,
    required this.userId,
    required this.body,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
    id: json["id"],
    conversationId: json["conversation_id"],
    userId: json["user_id"],
    body: json["body"],
    type: json["type"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "conversation_id": conversationId,
    "user_id": userId,
    "body": body,
    "type": type,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
  };
}

class Participant {
  int id;
  String name;
  String email;
  DateTime emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String avatarUrl;

  Participant({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.avatarUrl,
  });

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    avatarUrl: json["avatar_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "avatar_url": avatarUrl,
  };
}
