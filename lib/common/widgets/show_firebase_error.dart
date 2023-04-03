import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void showFirebaseErrorOnSnackBar(BuildContext context, Object? exception) {
  final snackBar = SnackBar(
    action: SnackBarAction(
      onPressed: () {
        context.pop();
      },
      label: "Ok",
      textColor: Colors.white,
    ),
    duration: const Duration(milliseconds: 2000),
    backgroundColor: Colors.redAccent,
    showCloseIcon: true,
    content: Text(
      (exception as FirebaseException).message ?? "Something went wrong",
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
