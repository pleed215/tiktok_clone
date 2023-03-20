import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/log_in.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';
import "package:tiktok_clone/generated/l10n.dart";

import '../../constants/gaps.dart';

class AuthItem {
  static Widget builder(
      {bool isPortrait = true, required List<Widget> children}) {
    List<Widget> newChildren = [
      for (int index = 0; index < children.length; index++) ...[
        if (!isPortrait) Expanded(child: children[index]),
        if (isPortrait) children[index],
        if (!isPortrait && index != children.length - 1) Gaps.h4,
        if (isPortrait && index != children.length - 1) Gaps.v4,
      ]
    ];

    return isPortrait
        ? Column(children: newChildren)
        : Row(children: newChildren);
  }
}

class SignUpScreen extends StatelessWidget {
  static String routeUrl = "/";
  static String routeName = "signup_screen";

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    S.load(Locale('ko'));
    return OrientationBuilder(builder: (context, orientation) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size40,
            ),
            child: Column(
              children: [
                Gaps.v80,
                Text(
                  S.of(context).signUpTitle(
                        "TikTok",
                        DateTime.now(),
                      ),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Gaps.v20,
                Opacity(
                  opacity: 0.7,
                  child: Text(
                    S.of(context).signUpSubTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: Sizes.size16,
                    ),
                  ),
                ),
                Gaps.v40,
                AuthItem.builder(
                    isPortrait: orientation == Orientation.portrait,
                    children: [
                      AuthButton(
                        icon: const FaIcon(FontAwesomeIcons.user),
                        text: "Use phone or email",
                        onTap: () {
                          // Navigator.of(context).push(PageRouteBuilder(
                          //   transitionDuration:
                          //       const Duration(milliseconds: 300),
                          //   reverseTransitionDuration:
                          //       const Duration(milliseconds: 300),
                          //   transitionsBuilder: (context, animation,
                          //       secondaryAnimation, child) {
                          //     final offsetAnimation = Tween(
                          //             begin: const Offset(0, 1),
                          //             end: Offset.zero)
                          //         .animate(animation);
                          //     return SlideTransition(
                          //         position: offsetAnimation, child: child);
                          //   },
                          //   pageBuilder:
                          //       (context, animation, secondaryAnimation) =>
                          //           const UsernameScreen(),
                          // ));
                          //context.push(UsernameScreen.routeUrl);
                          context.pushNamed(UsernameScreen.routeName);
                        },
                      ),
                      AuthButton(
                        icon: const FaIcon(FontAwesomeIcons.facebook),
                        text: "Continue with Facebook",
                        onTap: () {},
                      ),
                      AuthButton(
                        icon: const FaIcon(FontAwesomeIcons.apple),
                        text: "Continue with Apple",
                        onTap: () {},
                      ),
                      AuthButton(
                        icon: const FaIcon(FontAwesomeIcons.google),
                        text: "Continue with Google",
                        onTap: () {},
                      ),
                    ]),
                Gaps.v16,
                const Center(
                  child: FaIcon(
                    FontAwesomeIcons.chevronDown,
                  ),
                ),
                Text(S.of(context).pluralTest(1)),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: Sizes.size32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account?'),
                Gaps.h5,
                GestureDetector(
                  onTap: () async {
                    context.push(LogInScreen.routeUrl);
                  },
                  child: Text(
                    'Log in',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
