import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';
import 'package:tiktok_clone/features/user/view_model/users_view_model.dart';

import '../../../constants/sizes.dart';

class BioUpdateScreen extends ConsumerStatefulWidget {
  const BioUpdateScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _BioUpdateScreenState();
}

class _BioUpdateScreenState extends ConsumerState<BioUpdateScreen> {
  final _textEditingController = TextEditingController();
  late String _bio;

  @override
  void initState() {
    super.initState();
    final prevBio = ref.read(usersProvider).value?.bio;
    _bio = prevBio ?? "";
    _textEditingController.text = prevBio ?? "";
    _textEditingController.addListener(() {
      setState(() {
        _bio = _textEditingController.value.text;
      });
    });
  }

  void _onTap() {
    if (_textEditingController.value.text.isEmpty) return;
    ref
        .read(usersProvider.notifier)
        .updateBio(_textEditingController.value.text)
        .whenComplete(() {
      final snackBar = SnackBar(
        content: const Text(
          "Bio update successfully",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        showCloseIcon: true,
        duration: const Duration(seconds: 5),
        backgroundColor: Theme.of(context).primaryColor,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      context.pop();
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bio"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gaps.v40,
            TextField(
              controller: _textEditingController,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            Gaps.v10,
            FormButton(
              onTap: _onTap,
              disabled: _bio.isEmpty || ref.watch(usersProvider).isLoading,
              text: "Update",
            ),
          ],
        ),
      ),
    );
  }
}
