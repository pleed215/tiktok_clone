import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/view_models/signup_view_model.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import 'email_screen.dart';

class UsernameScreen extends ConsumerStatefulWidget {
  static String routeUrl = "username";
  static String routeName = "username_screen";

  const UsernameScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UsernameScreen> createState() => UsernameScreenState();
}

class UsernameScreenState extends ConsumerState<UsernameScreen> {
  final TextEditingController _usernameController = TextEditingController();
  String _username = "";

  @override
  void initState() {
    super.initState();

    _usernameController.addListener(() {
      setState(() {
        _username = _usernameController.text;
      });
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size36,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v40,
            const Text(
              "Create username",
              style: TextStyle(
                  fontSize: Sizes.size24, fontWeight: FontWeight.w600),
            ),
            Gaps.v8,
            const Text(
              "You can always change this later.",
              style: TextStyle(
                fontSize: Sizes.size16,
                color: Colors.black54,
              ),
            ),
            Gaps.v16,
            TextField(
              controller: _usernameController,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                hintText: "Username",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
            ),
            Gaps.v16,
            FormButton(
              disabled: _username.isEmpty,
              onTap: () {
                final args = EmailScreenArgs(username: _username);
                ref.read(signUpFormStateProvider.notifier).state = {
                  'username': _username,
                };
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EmailScreen(args: args),
                ));
                // Navigator.of(context).pushNamed(EmailScreen.routeName,
                //     arguments: EmailScreenArgs(username: _username));
              },
            )
          ],
        ),
      ),
    );
  }
}
