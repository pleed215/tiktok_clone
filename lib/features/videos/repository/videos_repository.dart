import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/video_model.dart';

class VideosRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

// TODO: Upload video file.
// TODO: Create video document.
  UploadTask uploadVideo(String userId, File video) {
    final fileRef = _storage.ref().child(
        '/videos/$userId/${DateTime.now().millisecondsSinceEpoch.toString()}');
    return fileRef.putFile(video);
  }

  Future<void> saveVideo(VideoModel data) async {
    await _db.collection('videos').add(data.toMap());
  }
}

final videosRepository = Provider(
  (ref) => VideosRepository(),
);
