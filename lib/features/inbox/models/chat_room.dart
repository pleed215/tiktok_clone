class ChatRoomModel {
  final String id;
  final List<String> userIds;

  const ChatRoomModel({
    required this.id,
    required this.userIds,
  });

  ChatRoomModel copyWith({
    String? id,
    List<String>? userIds,
  }) {
    return ChatRoomModel(
      id: id ?? this.id,
      userIds: userIds ?? this.userIds,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userIds': userIds,
    };
  }

  factory ChatRoomModel.fromMap(Map<String, dynamic> map) {
    return ChatRoomModel(
      id: map['id'] as String,
      userIds: map['userIds'] as List<String>,
    );
  }

  List<String> getUserIds() {
    return userIds.map((idName) => idName.split("___")[0]).toList();
  }

  List<String> getUserNames() {
    return userIds.map((idName) => idName.split("___")[1]).toList();
  }

  String getChatWithId(String myId) {
    return userIds
        .firstWhere((element) => !element.startsWith(myId))
        .split("___")[0];
  }

  String getChatWithName(String myId) {
    print(myId);
    print(userIds);
    return userIds
        .firstWhere((element) => !element.startsWith(myId))
        .split("___")[1];
  }
}
