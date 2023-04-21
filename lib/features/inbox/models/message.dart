class MessageModel {
  final String text;
  final String userId;
  final int createdAt;

  MessageModel({
    required this.text,
    required this.userId,
    int? createdAt,
  }) : createdAt = createdAt ?? DateTime.now().millisecondsSinceEpoch;

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'userId': userId,
      'createdAt': createdAt,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      text: map['text'] as String,
      userId: map['userId'] as String,
      createdAt: map['createdAt'] as int,
    );
  }

  MessageModel copyWith({
    String? text,
    String? userId,
    int? createdAt,
  }) {
    return MessageModel(
      text: text ?? this.text,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
