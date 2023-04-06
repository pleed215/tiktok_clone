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
    duration: const Duration(milliseconds: 5000),
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

void showSuccessMessage(BuildContext context, String message) {
  final snackBar = SnackBar(
    duration: const Duration(milliseconds: 5000),
    backgroundColor: Theme.of(context).primaryColor,
    showCloseIcon: true,
    content: Text(
      message,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
