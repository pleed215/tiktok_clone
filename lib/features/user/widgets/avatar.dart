import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/features/user/view_model/avatar_view_model.dart';

class Avatar extends ConsumerWidget {
  final String name;
  final bool hasAvatar;
  final String uid;

  const Avatar({
    Key? key,
    required this.name,
    required this.hasAvatar,
    required this.uid,
  }) : super(key: key);

  void _onAvatarTap(WidgetRef ref) async {
    final imageFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 40,
        maxHeight: 150,
        maxWidth: 150);
    if (imageFile == null) return;

    final file = File(imageFile.path);
    ref.read(avatarProvider.notifier).uploadAvatar(file);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(avatarProvider).isLoading;
    print(isLoading);
    return GestureDetector(
      onTap: isLoading ? null : () => _onAvatarTap(ref),
      child: isLoading
          ? Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: const CircularProgressIndicator(),
            )
          : CircleAvatar(
              radius: 50,
              foregroundColor: Colors.teal,
              foregroundImage: hasAvatar
                  ? NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/clone-tiktok-"
                      "pleed0215.appspot.com/o/avatars%2F$uid?alt=media&sometrick=${DateTime.now()}")
                  : null,
              child: Text(name),
            ),
    );
  }
}
