import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/email_screen.dart';
import 'package:tiktok_clone/features/authentication/log_in.dart';
import 'package:tiktok_clone/features/authentication/sign_up.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/user/user_profile_screen.dart';
import 'package:tiktok_clone/features/videos/video_recording_screen.dart';

final router = GoRouter(routes: [
  GoRoute(
    name: VideoRecordingScreen.routeName,
    path: VideoRecordingScreen.routeUrl,
    builder: (context, state) => const VideoRecordingScreen(),
  ),
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
    builder: (context, state) => const LogInScreen(),
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
  )
]);
