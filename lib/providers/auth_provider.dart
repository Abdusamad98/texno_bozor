import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:texno_bozor/data/firebase/auth_service.dart';
import 'package:texno_bozor/data/models/universal_data.dart';

class AuthProvider with ChangeNotifier {
  AuthProvider({required this.firebaseServices});

  final AuthService firebaseServices;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();

  bool isLoading = false;

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
    notify(true);
    UniversalData universalData =
        await firebaseServices.signUpUser(email: email, password: password);
    notify(false);

    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showMessage(context, "User signed Up");
      }
    } else {
      if (context.mounted) {
        showMessage(context, universalData.error);
      }
    }
  }

  Stream<User?> listenAuthState() => FirebaseAuth.instance.authStateChanges();

  Future<void> logInUser(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;
    notify(true);
    UniversalData universalData =
        await firebaseServices.loginUser(email: email, password: password);
    notify(false);

    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showMessage(context, "User Logged in");
      }
    } else {
      if (context.mounted) {
        showMessage(context, universalData.error);
      }
    }
  }

  Future<void> logOutUser(BuildContext context) async {
    notify(true);
    UniversalData universalData = await firebaseServices.logOutUser();
    notify(false);
    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showMessage(context, universalData.data as String);
      }
    } else {
      if (context.mounted) {
        showMessage(context, universalData.error);
      }
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    notify(true);
    UniversalData universalData = await firebaseServices.signInWithGoogle();
    notify(false);

    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showMessage(context, "User Signed Up with Google.");
      }
    } else {
      if (context.mounted) {
        showMessage(context, universalData.error);
      }
    }
  }

  notify(bool value) {
    isLoading = value;
    notifyListeners();
  }

  showMessage(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    isLoading = false;
    notifyListeners();
  }
}
