import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/common/widgets/show_firebase_error.dart';
import 'package:tiktok_clone/features/authentication/repository/authentication_repository.dart';

class LoginViewModel extends AsyncNotifier<void> {
  late AuthenticationRepository _authRepository;

  @override
  FutureOr<void> build() {
    _authRepository = ref.read(authRepo);
  }

  Future<void> loginWithEmailPassword(
      String email, String password, BuildContext context) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(
      () => _authRepository.loginWithEmailAndPassword(email, password),
    );

    if (state.hasError) {
      if (context.mounted) {
        showFirebaseErrorOnSnackBar(context, state.error);
      }
    }
  }
}

final loginProvider = AsyncNotifierProvider<LoginViewModel, void>(
  () => LoginViewModel(),
);
