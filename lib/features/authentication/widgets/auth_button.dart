import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final FaIcon icon;
  final GestureTapCallback onTap;

  const AuthButton(
      {Key? key, required this.text, required this.icon, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: FractionallySizedBox(
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
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: icon,
                ),
                Text(text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: Sizes.size16,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
