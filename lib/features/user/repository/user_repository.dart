import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_profile_model.dart';

class UserRepository {
  // TODO: Create profile
  // TODO: Get Profile
  // TODO: Update Profile
  // TODO: Update Avatar
  // TODO: Update Bio
  // TODO: Update Link

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> createProfile(UserProfileModel userProfile) async {
    _db.collection("users").doc(userProfile.uid).set(userProfile.toMap());
  }

  Future<Map<String, dynamic>?> findProfile(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    return doc.data();
  }

  void uploadAvatar(File file, String uid) async {
    final fileRef = _storage.ref().child("/avatars/$uid");
    await fileRef.putFile(file);
  }

  Future<void> updateUser(String uid, Map<String, dynamic> update) async {
    await _db.collection('users').doc(uid).update(update);
  }
}

final userRepository = Provider(
  (ref) => UserRepository(),
);
