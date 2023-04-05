import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';
import 'package:tiktok_clone/features/user/view_model/users_view_model.dart';

import '../../../constants/sizes.dart';

class LinkUpdateScreen extends ConsumerStatefulWidget {
  const LinkUpdateScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _LinkUpdateScreenState();
}

class _LinkUpdateScreenState extends ConsumerState<LinkUpdateScreen> {
  final _textEditingController = TextEditingController();
  late String _link;

  @override
  void initState() {
    super.initState();
    final prevLink = ref.read(usersProvider).value?.link;
    _link = prevLink ?? "";
    _textEditingController.text = prevLink ?? "";
    _textEditingController.addListener(() {
      setState(() {
        _link = _textEditingController.value.text;
      });
    });
  }

  void _onTap() {
    if (_textEditingController.value.text.isEmpty) return;
    ref
        .read(usersProvider.notifier)
        .updateLink(_textEditingController.value.text)
        .whenComplete(() {
      final snackBar = SnackBar(
        content: const Text(
          "Link update successfully",
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
          title: const Text("Link"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size20,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Gaps.v40,
            TextField(
              controller: _textEditingController,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                prefixIcon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.link,
                      size: Sizes.size16,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
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
              disabled: _link.isEmpty || ref.watch(usersProvider).isLoading,
              text: "Update Link",
            ),
          ]),
        ));
  }
}
