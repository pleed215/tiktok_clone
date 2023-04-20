import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/repository/authentication_repository.dart';

import '../../../common/widgets/show_firebase_error.dart';

class SocialSignViewModel extends AsyncNotifier<void> {
  late AuthenticationRepository _authRepository;

  @override
  FutureOr<void> build() {
    _authRepository = ref.read(authRepo);
  }

  void loginWithGithub(BuildContext context) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => _authRepository.loginWithGithub(),
    );
    if (state.hasError) {
      if (context.mounted) {
        showFirebaseErrorOnSnackBar(context, state.error);
      }
      return;
    }
    if (context.mounted) {
      context.go("/home");
    }
  }
}

final socialSignProvider = AsyncNotifierProvider(
  () => SocialSignViewModel(),
);
