import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/common/widgets/show_firebase_error.dart';
import 'package:tiktok_clone/features/authentication/respository/authentication_repository.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';
import 'package:tiktok_clone/features/user/view_model/users_view_model.dart';

class SignupViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signUp(BuildContext context) async {
    state = const AsyncValue.loading();
    final formState = ref.read(signUpFormStateProvider.notifier).state;

    state = await AsyncValue.guard(
      () async {
        final userCredential = await _authRepo.emailSignUp(
            email: formState['email'], password: formState['password']);
        if (userCredential.user != null) {
          final users = ref.read(usersProvider.notifier);
          await users.createProfile(userCredential);
        }
      },
    );

    if (context.mounted) {
      if (state.hasError) {
        if (context.mounted) {
          showFirebaseErrorOnSnackBar(context, state.error);
        }
      } else {
        context.goNamed(InterestsScreen.routeName);
      }
    }
  }
}

final signUpFormStateProvider = StateProvider((ref) => {});
final signUpProvider = AsyncNotifierProvider<SignupViewModel, void>(
  () => SignupViewModel(),
);
