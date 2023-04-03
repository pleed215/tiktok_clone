import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/view_models/signup_view_model.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';

class BirthdayScreen extends ConsumerStatefulWidget {
  const BirthdayScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<BirthdayScreen> createState() => BirthdayScreenState();
}

class BirthdayScreenState extends ConsumerState<BirthdayScreen> {
  final TextEditingController _birthdayController = TextEditingController();
  final DateTime _initialDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    _birthdayController.text = _initialDate.toString().split(" ").first;

    _birthdayController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _birthdayController.dispose();
    super.dispose();
  }

  void _onChangeDate(DateTime date) {
    final dateText = date.toString().split(" ").first;
    _birthdayController.text = dateText;
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
              "When is your birthday?",
              style: TextStyle(
                  fontSize: Sizes.size24, fontWeight: FontWeight.w600),
            ),
            Gaps.v8,
            const Text(
              "Your birthday won't be shown publicly",
              style: TextStyle(
                fontSize: Sizes.size16,
                color: Colors.black54,
              ),
            ),
            Gaps.v16,
            TextField(
              controller: _birthdayController,
              cursorColor: Theme.of(context).primaryColor,
              enabled: false,
              decoration: InputDecoration(
                hintText: "Birthday",
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
              disabled: ref.watch(signUpProvider).isLoading,
              onTap: () {
                ref.read(signUpProvider.notifier).signUp(context);
                // Navigator.of(context).pushAndRemoveUntil(
                //   MaterialPageRoute(
                //     builder: (context) => const InterestsScreen(),
                //   ),
                //   (route) => false,
                // );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 300,
        child: CupertinoDatePicker(
          onDateTimeChanged: _onChangeDate,
          mode: CupertinoDatePickerMode.date,
          maximumDate: _initialDate,
          initialDateTime: _initialDate,
        ),
      ),
    );
  }
}
