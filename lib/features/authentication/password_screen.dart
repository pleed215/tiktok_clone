import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/features/authentication/birthday_screen.dart';
import 'package:tiktok_clone/features/authentication/view_models/signup_view_model.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';

class PasswordScreen extends ConsumerStatefulWidget {
  const PasswordScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PasswordScreen> createState() => PasswordScreenState();
}

class PasswordScreenState extends ConsumerState<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  String _password = "";
  bool _obscureText = true;
  bool _lengthCheck = false;
  bool _characterCheck = false;

  @override
  void initState() {
    super.initState();

    _passwordController.addListener(() {
      _password = _passwordController.text;
      _checkLength();
      _checkCharacters();
      setState(() {});
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _onSubmit(BuildContext context) {
    if (_password.isNotEmpty && _lengthCheck && _characterCheck) {
      final prevState = ref.read(signUpFormStateProvider.notifier).state;
      ref.read(signUpFormStateProvider.notifier).state = {
        ...prevState,
        'password': _password,
      };
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const BirthdayScreen()));
    }
  }

  void _onTapClear() {
    _passwordController.clear();
  }

  void _onTapPasswordVisible() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _checkLength() {
    final regex = RegExp(r"\b\w{8,20}\b");
    _lengthCheck = _password.isEmpty ? false : regex.hasMatch(_password);
  }

  void _checkCharacters() {
    final regex = RegExp(
        r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[*.!@$%^&(){}[\]:;<>,.?/~_+\-=|\\]).{1,}$");
    _characterCheck = _password.isEmpty ? false : regex.hasMatch(_password);
  }

  @override
  Widget build(BuildContext context) {
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
              const Text(
                "Password",
                style: TextStyle(
                    fontSize: Sizes.size24, fontWeight: FontWeight.w600),
              ),
              Gaps.v16,
              TextField(
                controller: _passwordController,
                // onSubmitted: (value) => _onSubmit(context),
                onEditingComplete: () => _onSubmit(context),
                cursorColor: Theme.of(context).primaryColor,
                obscureText: _obscureText,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: "Password",
                  suffix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: _onTapClear,
                        child: FaIcon(
                          FontAwesomeIcons.solidCircleXmark,
                          color: Colors.grey.shade500,
                          size: Sizes.size20,
                        ),
                      ),
                      Gaps.h10,
                      GestureDetector(
                        onTap: _onTapPasswordVisible,
                        child: FaIcon(
                          _obscureText
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          color: Colors.grey.shade500,
                          size: Sizes.size20,
                        ),
                      ),
                    ],
                  ),
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
              Gaps.v10,
              const Text("Your password must have:",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  )),
              Gaps.v10,
              Row(
                children: [
                  FaIcon(
                    _lengthCheck
                        ? FontAwesomeIcons.circleCheck
                        : FontAwesomeIcons.circleXmark,
                    color: _lengthCheck ? Colors.lightGreen : Colors.redAccent,
                  ),
                  Gaps.h8,
                  const Text("8 to 20 characters"),
                ],
              ),
              Gaps.v4,
              Row(
                children: [
                  FaIcon(
                    _characterCheck
                        ? FontAwesomeIcons.circleCheck
                        : FontAwesomeIcons.circleXmark,
                    color:
                        _characterCheck ? Colors.lightGreen : Colors.redAccent,
                  ),
                  Gaps.h8,
                  const Text("Letters, numbers, and special characters"),
                ],
              ),
              Gaps.v40,
              FormButton(
                disabled:
                    _password.isEmpty || !_lengthCheck || !_characterCheck,
                onTap: () => _onSubmit(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
