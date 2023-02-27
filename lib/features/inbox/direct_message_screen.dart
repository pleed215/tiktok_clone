import 'package:flutter/material.dart';

class DirectMessageScreen extends StatefulWidget {
  const DirectMessageScreen({Key? key}) : super(key: key);

  @override
  State<DirectMessageScreen> createState() => _DirectMessageScreenState();
}

class _DirectMessageScreenState extends State<DirectMessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Direct Message Screen"),
      ),
    );
  }
}
