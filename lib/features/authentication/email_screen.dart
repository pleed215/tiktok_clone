import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/password_screen.dart';
import 'package:tiktok_clone/features/authentication/view_models/signup_view_model.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';

class EmailScreenArgs {
  final String username;

  EmailScreenArgs({required this.username});
}

class EmailScreen extends ConsumerStatefulWidget {
  static String routeUrl = 'email';
  static String routeName = "email_screen";
  final EmailScreenArgs args;

  const EmailScreen({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  ConsumerState<EmailScreen> createState() => EmailScreenState();
}

class EmailScreenState extends ConsumerState<EmailScreen> {
  final TextEditingController _emailController = TextEditingController();
  String _email = "";

  @override
  void initState() {
    super.initState();

    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  String? _isEmailValid() {
    if (_email.isEmpty) {
      return null;
    }

    if (_email.isNotEmpty) {
      final emailRegex = RegExp(r"[\w-.]+@([\w-]+\.)+[\w-]{2,4}");
      if (emailRegex.hasMatch(_email)) {
        return null;
      }
    }
    return "Not Valid";
  }

  void _onSubmit(BuildContext context) {
    if (_email.isNotEmpty && _isEmailValid() == null) {
      final prevState = ref.read(signUpFormStateProvider.notifier).state;
      ref.read(signUpFormStateProvider.notifier).state = {
        ...prevState,
        'email': _email,
      };
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const PasswordScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)!.settings.arguments as EmailScreenArgs;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
              Text(
                "What is your email, ${widget.args.username}?",
                style: const TextStyle(
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
                controller: _emailController,
                // onSubmitted: (value) => _onSubmit(context),
                onEditingComplete: () => _onSubmit(context),
                cursorColor: Theme.of(context).primaryColor,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: "Email",
                  errorText: _isEmailValid(),
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
                disabled: _email.isEmpty || _isEmailValid() != null,
                onTap: () => _onSubmit(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
