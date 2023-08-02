import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:texno_bozor/providers/auth_provider.dart';
import 'package:texno_bozor/ui/auth/widgets/global_button.dart';
import 'package:texno_bozor/ui/auth/widgets/global_text_fields.dart';
import 'package:texno_bozor/utils/images/app_images.dart';

import '../../../splash/splash_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key, required this.onChanged});

  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height / 12),
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
          hintText: "Username",
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          textAlign: TextAlign.start,
          controller: context.read<AuthProvider>().userNameController,
        ),
        const SizedBox(
          height: 24,
        ),
        GlobalTextField(
          hintText: "Email",
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          textAlign: TextAlign.start,
          controller: context.read<AuthProvider>().emailController,
        ),
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
            title: "Sign up",
            onTap: () {
              context.read<AuthProvider>().signUpUser(context);
            }),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () {
                  onChanged.call();
                  context.read<AuthProvider>().loginButtonPressed();
                },
                child: Text("Log In",
                    style: TextStyle(
                        color: Color(0xFF4F8962),
                        fontSize: 18,
                        fontWeight: FontWeight.w800)))
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: TextButton(
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
        )
      ],
    );
  }
}
