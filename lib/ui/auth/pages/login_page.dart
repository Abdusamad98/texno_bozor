import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:texno_bozor/providers/auth_provider.dart';
import 'package:texno_bozor/ui/auth/widgets/global_button.dart';
import 'package:texno_bozor/ui/auth/widgets/global_text_fields.dart';

import '../../../splash/splash_screen.dart';
import '../../../utils/images/app_images.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key, required this.onChanged});

  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_cart,
                color: Color(0xFF4F8962),
                size: 50,
              ),
              Text(
                'Texno Bazar',
                style: TextStyle(
                    color: Color(0xFF4F8962),
                    fontWeight: FontWeight.w800,
                    fontSize: 30),
              )
            ],
          ),
          SizedBox(height: 20),
          GlobalTextField(
              hintText: "Email",
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              textAlign: TextAlign.start,
              controller: context.read<AuthProvider>().emailController),
          const SizedBox(height: 24),
          GlobalTextField(
            hintText: "Password",
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            textAlign: TextAlign.start,
            controller: context.read<AuthProvider>().passwordController,
          ),
          const SizedBox(height: 24),
          GlobalButton(
              title: "Log In",
              onTap: () {
                context.read<AuthProvider>().logInUser(context);
              }),
          const SizedBox(height: 24),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      onChanged.call();
                      context.read<AuthProvider>().signUpButtonPressed();
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Color(0xFF4F8962),
                          fontSize: 18,
                          fontWeight: FontWeight.w800),
                    )),
              ],
            ),
          ),
          TextButton(
              onPressed: () {
                context.read<AuthProvider>().signInWithGoogle(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 12),
                  SvgPicture.asset(AppImages.google, height: 50),
                  const Text("Sign Up with Google",
                      style: TextStyle(
                          color: Color(0xFF4F8962),
                          fontSize: 18,
                          fontWeight: FontWeight.w800)),
                ],
              )),
        ],
      ),
    );
  }
}
