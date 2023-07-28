import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:texno_bozor/data/firebase/auth_service.dart';
import 'package:texno_bozor/data/models/universal_data.dart';
import 'package:texno_bozor/utils/ui_utils/error_message_dialog.dart';
import 'package:texno_bozor/utils/ui_utils/loading_dialog.dart';

class AuthProvider with ChangeNotifier {
  AuthProvider({required this.firebaseServices});

  final AuthService firebaseServices;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();

  loginButtonPressed() {
    passwordController.clear();
    emailController.clear();
    userNameController.clear();
  }

  signUpButtonPressed() {
    passwordController.clear();
    emailController.clear();
  }

  Future<void> signUpUser(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;
    showLoading(context: context);
    UniversalData universalData =
        await firebaseServices.signUpUser(email: email, password: password);
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }

    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showConfirmMessage(message: "User signed Up", context: context);
      }
    } else {
      if (context.mounted) {
        showErrorMessage(message: universalData.error, context: context);
      }
    }
  }

  Stream<User?> listenAuthState() => FirebaseAuth.instance.authStateChanges();

  Future<void> logInUser(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;
    showLoading(context: context);
    UniversalData universalData =
        await firebaseServices.loginUser(email: email, password: password);
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }

    if (universalData.error.isEmpty) {
      if (context.mounted) {
      // showConfirmMessage(message: "User logged", context: context);
      }
    } else {
      if (context.mounted) {
        showErrorMessage(message: universalData.error, context: context);
      }
    }
  }

  Future<void> logOutUser(BuildContext context) async {
    showLoading(context: context);
    UniversalData universalData = await firebaseServices.logOutUser();
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showConfirmMessage(
          message: universalData.data as String,
          context: context,
        );
      }
    } else {
      if (context.mounted) {
        showErrorMessage(message: universalData.error, context: context);
      }
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    showLoading(context: context);
    UniversalData universalData = await firebaseServices.signInWithGoogle();

    if (context.mounted) {
      hideLoading(dialogContext: context);
    }

    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showConfirmMessage(
            message: "User Signed Up with Google.", context: context);
      }
    } else {
      if (context.mounted) {
        showErrorMessage(message: universalData.error, context: context);
      }
    }
  }
}
