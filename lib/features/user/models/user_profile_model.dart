import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileModel {
  final String email;
  final String name;
  final String uid;
  final String bio;
  final String link;
  final bool hasAvatar;
  DateTime? birthday;

  UserProfileModel(
      {required this.email,
      required this.name,
      required this.uid,
      required this.bio,
      required this.link,
      required this.hasAvatar,
      this.birthday});

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "bio": bio,
      "link": link,
      'birthday': birthday,
      'hasAvatar': hasAvatar,
    };
  }

  UserProfileModel.fromMap(Map<String, dynamic> profile)
      : uid = profile['uid'],
        email = profile['email'],
        name = profile['name'],
        bio = profile['bio'],
        birthday = (profile['birthday'] as Timestamp).toDate(),
        link = profile['link'],
        hasAvatar = profile['hasAvatar'];

  UserProfileModel.empty()
      : uid = "",
        email = "",
        name = "",
        bio = "",
        link = "",
        hasAvatar = false;

  UserProfileModel copyWith(
      {String? email,
      String? name,
      String? uid,
      String? bio,
      String? link,
      bool? hasAvatar,
      DateTime? birthday}) {
    return UserProfileModel(
        email: email ?? this.email,
        name: name ?? this.name,
        uid: uid ?? this.uid,
        bio: bio ?? this.bio,
        link: link ?? this.link,
        hasAvatar: hasAvatar ?? this.hasAvatar);
  }
}
