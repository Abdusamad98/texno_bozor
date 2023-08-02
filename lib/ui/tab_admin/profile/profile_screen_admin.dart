import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';
import '../../../providers/profiles_provider.dart';
import '../../auth/widgets/global_button.dart';
import '../../auth/widgets/global_text_fields.dart';


class ProfileScreenAdmin extends StatefulWidget {
  const ProfileScreenAdmin({super.key});

  @override
  State<ProfileScreenAdmin> createState() => _ProfileScreenAdminState();
}

class _ProfileScreenAdminState extends State<ProfileScreenAdmin> {
  @override
  Widget build(BuildContext context) {
    User? user = context.watch<ProfileProvider>().currentUser;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF4F8962),
        title: const Text("Profile"),
        actions: [
          IconButton(
              onPressed: () {
                context.read<AuthProvider>().logOutUser(context);
    },
              icon: Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Image.network(
                user?.photoURL ?? "",
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 50),
              GlobalTextField(
                hintText: "${user?.displayName}",
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                controller: context.read<ProfileProvider>().nameController, textAlign: TextAlign.center,

              ),
              SizedBox(height: 20),
              GlobalTextField(
                hintText: "${user?.email}",
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                controller: context.read<ProfileProvider>().emailController, textAlign: TextAlign.center,

              ),
              SizedBox(height: 50),
              GlobalButton(

                  onTap: () {
                    context.read<ProfileProvider>().updateUsername(context);
                    context.read<ProfileProvider>().updateEmail(context);
                    context.read<ProfileProvider>().updateUserImage(context,
                        "https://cdn-icons-png.flaticon.com/512/3135/3135715.png");
                  }, title: 'Update',)
            ],
          ),

        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}