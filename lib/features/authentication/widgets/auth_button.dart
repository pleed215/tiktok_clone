import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class AuthButton extends StatelessWidget {
  final String text;

  const AuthButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1.0,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
          color: Colors.grey.shade200,
          width: Sizes.size1,
        )),
        child: Padding(
          padding: const EdgeInsets.all(
            Sizes.size14,
          ),
          child: Text(text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size16,
              )),
        ),
      ),
    );
  }
}
