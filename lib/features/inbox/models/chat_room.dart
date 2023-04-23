class ChatRoomModel {
  String chatRoomId;
  String partnerId;
  String partnerName;

//<editor-fold desc="Data Methods">

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatRoomModel &&
          runtimeType == other.runtimeType &&
          chatRoomId == other.chatRoomId &&
          partnerId == other.partnerId &&
          partnerName == other.partnerName);

  @override
  int get hashCode =>
      chatRoomId.hashCode ^ partnerId.hashCode ^ partnerName.hashCode;

  @override
  String toString() {
    return 'ChatRoomModel{ roomId: $chatRoomId, partnerId: $partnerId, partnerName: $partnerName,}';
  }

  ChatRoomModel copyWith({
    String? roomId,
    String? partnerId,
    String? partnerName,
  }) {
    return ChatRoomModel(
      chatRoomId: roomId ?? chatRoomId,
      partnerId: partnerId ?? this.partnerId,
      partnerName: partnerName ?? this.partnerName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chatRoomId': chatRoomId,
      'partnerId': partnerId,
      'partnerName': partnerName,
    };
  }

  factory ChatRoomModel.fromMap(Map<String, dynamic> map) {
    return ChatRoomModel(
      chatRoomId: map['chatRoomId'] as String,
      partnerId: map['partnerId'] as String,
      partnerName: map['partnerName'] as String,
    );
  }

  ChatRoomModel({
    required this.chatRoomId,
    required this.partnerId,
    required this.partnerName,
  });
//</editor-fold>
}
