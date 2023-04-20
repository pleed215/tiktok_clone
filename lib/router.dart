import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/common/widgets/main_screen.dart';
import 'package:tiktok_clone/features/authentication/email_screen.dart';
import 'package:tiktok_clone/features/authentication/log_in.dart';
import 'package:tiktok_clone/features/authentication/repository/authentication_repository.dart';
import 'package:tiktok_clone/features/authentication/signup_screen.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/inbox/activity_screen.dart';
import 'package:tiktok_clone/features/inbox/chat_screen.dart';
import 'package:tiktok_clone/features/inbox/direct_message_screen.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';
import 'package:tiktok_clone/features/user/user_profile_screen.dart';
import 'package:tiktok_clone/features/videos/views/video_recording_screen.dart';

final routerProvider = Provider((ref) {
  // ref.watch(authStateStream);
  return GoRouter(
    initialLocation: "/home",
    redirect: (context, state) {
      final isLoggedIn = ref.read(authRepo).isLoggedIn;
      if (!isLoggedIn &&
          state.subloc != SignUpScreen.routeUrl &&
          state.subloc != LogInScreen.routeUrl) {
        return SignUpScreen.routeUrl;
      }
      return null;
    },
    routes: [
      GoRoute(
        name: SignUpScreen.routeName,
        path: SignUpScreen.routeUrl,
        builder: (context, state) => const SignUpScreen(),
        routes: [
          GoRoute(
            name: UsernameScreen.routeName,
            path: UsernameScreen.routeUrl,
            builder: (context, state) => const UsernameScreen(),
          ),
          GoRoute(
            name: EmailScreen.routeName,
            path: EmailScreen.routeUrl,
            builder: (context, state) {
              final args = state.extra as EmailScreenArgs;
              return EmailScreen(
                args: args,
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: LogInScreen.routeUrl,
        name: LogInScreen.routeName,
        builder: (context, state) => const LogInScreen(),
      ),
      GoRoute(
        path: InterestsScreen.routeUrl,
        name: InterestsScreen.routeName,
        builder: (context, state) => const InterestsScreen(),
      ),
      GoRoute(
        path: "/:tab(home|discover|inbox|profile)",
        name: MainScreen.routeName,
        builder: (context, state) {
          final tab = state.params['tab'];
          return MainScreen(tab: tab!);
        },
      ),
      GoRoute(
        path: ActivityScreen.routeUrl,
        name: ActivityScreen.routeName,
        builder: (context, state) => const ActivityScreen(),
      ),
      GoRoute(
        path: DirectMessageScreen.routeUrl,
        name: DirectMessageScreen.routeName,
        builder: (context, state) => const DirectMessageScreen(),
        routes: [
          GoRoute(
            path: ChatScreen.routeUrl,
            name: ChatScreen.routeName,
            builder: (context, state) {
              final id = state.params['id']!;
              return ChatScreen(chatId: id);
            },
          ),
        ],
      ),
      GoRoute(
        path: VideoRecordingScreen.routeUrl,
        name: VideoRecordingScreen.routeName,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const VideoRecordingScreen(),
            transitionDuration: const Duration(milliseconds: 150),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final position = Tween(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation);
              return SlideTransition(position: position, child: child);
            },
          );
        },
      ),
      // GoRoute(
      //   path: UsernameScreen.routeName,
      //   // builder: (context, state) => const UsernameScreen(),
      //   pageBuilder: (context, state) {
      //     return CustomTransitionPage(
      //       child: const UsernameScreen(),
      //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //         final sliderAnimation = Tween(
      //           begin: const Offset(0, 0.2),
      //           end: Offset.zero,
      //         ).animate(animation);
      //         return SlideTransition(position: sliderAnimation, child: child);
      //       },
      //     );
      //   },
      // ),
      // GoRoute(
      //   path: EmailScreen.routeName,
      //   builder: (context, state) {
      //     final args = state.extra as EmailScreenArgs;
      //     return EmailScreen(
      //       args: args,
      //     );
      //   },
      // ),
      GoRoute(
        path: "/users/:username",
        builder: (context, state) {
          print(state.params);
          print(state.queryParams);
          return UserProfileScreen();
        },
      ),
    ],
  );
});
