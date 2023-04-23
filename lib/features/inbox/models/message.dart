class MessageModel {
  final String text;
  final String userId;
  final String id;
  final int createdAt;

  MessageModel({
    required this.text,
    required this.userId,
    String? id,
    int? createdAt,
  })  : createdAt = createdAt ?? DateTime.now().millisecondsSinceEpoch,
        id = id ?? "";

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'userId': userId,
      'createdAt': createdAt,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map, String id) {
    return MessageModel(
      text: map['text'] as String,
      userId: map['userId'] as String,
      createdAt: map['createdAt'] as int,
      id: id,
    );
  }

  MessageModel copyWith({
    String? text,
    String? userId,
    int? createdAt,
  }) {
    return MessageModel(
      id: id,
      text: text ?? this.text,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
