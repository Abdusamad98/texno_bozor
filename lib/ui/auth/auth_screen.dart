import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:texno_bozor/providers/auth_provider.dart';
import 'package:texno_bozor/ui/auth/pages/login_page.dart';
import 'package:texno_bozor/ui/auth/pages/signup_page.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLoginPage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(isLoginPage ? "Login" : "Sign Up",style: TextStyle(color: Color(0xFF4F8962),fontWeight: FontWeight.w800,fontSize: 25),),
      ),
      body: isLoginPage
          ? LoginPage(
              onChanged: () {
                setState(() {
                  isLoginPage = false;
                });
              },
            )
          : SignUpScreen(
              onChanged: () {
                setState(() {
                  isLoginPage = true;
                });
              },
            ),
      backgroundColor: Colors.white,
    );
  }
}
