class VideoModel {
  String title;
  String description;
  String fileUrl;
  String thumbnailUrl;
  String creatorUid;
  String creator;
  int likes;
  int comments;
  int createdAt;

  VideoModel(
      {required this.title,
      required this.description,
      required this.fileUrl,
      required this.thumbnailUrl,
      required this.creatorUid,
      required this.creator,
      required this.likes,
      required this.comments,
      required this.createdAt});

  VideoModel.dummy()
      : title = 'Ubi est bi-color elevatus?',
        description = '',
        fileUrl = '',
        thumbnailUrl = '',
        creatorUid = '',
        creator = '',
        createdAt = 0,
        likes = 0,
        comments = 0;

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'fileUrl': fileUrl,
      'thumbnailUrl': thumbnailUrl,
      'creatorUid': creatorUid,
      'creator': creator,
      'likes': likes,
      'comments': comments,
      'createdAt': createdAt,
    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      title: map['title'] as String,
      description: map['description'] as String,
      fileUrl: map['fileUrl'] as String,
      thumbnailUrl: map['thumbnailUrl'] as String,
      creatorUid: map['creatorUid'] as String,
      creator: map['creator'] as String,
      likes: map['likes'] as int,
      comments: map['comments'] as int,
      createdAt: map['createdAt'] as int,
    );
  }

  VideoModel copyWith({
    String? title,
    String? description,
    String? fileUrl,
    String? thumbnailUrl,
    String? creatorUid,
    String? creator,
    int? likes,
    int? comments,
    int? createdAt,
  }) {
    return VideoModel(
      title: title ?? this.title,
      description: description ?? this.description,
      fileUrl: fileUrl ?? this.fileUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      creatorUid: creatorUid ?? this.creatorUid,
      creator: creator ?? this.creator,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
