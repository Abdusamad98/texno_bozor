import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:texno_bozor/providers/auth_provider.dart';
import 'package:texno_bozor/ui/auth/widgets/global_button.dart';
import 'package:texno_bozor/ui/auth/widgets/global_text_fields.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key, required this.onChanged});

  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: ListView(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height / 6),
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
          GlobalButton(title: "Sign up", onTap: () {
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
                  child: Text("Log In"))
            ],
          )
        ],
      ),
    );
  }
}
