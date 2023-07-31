import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:texno_bozor/providers/auth_provider.dart';
import 'package:texno_bozor/providers/profiles_provider.dart';
import 'package:texno_bozor/ui/auth/widgets/global_text_fields.dart';

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
        title: const Text("Profile"),
        actions: [
          IconButton(
              onPressed: () {
                context.read<AuthProvider>().logOutUser(context);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            Image.network(
              user?.photoURL ?? "",
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                user?.email ?? "Empty",
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            Center(
              child: Text(
                user?.displayName ?? "Empty",
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            Center(
              child: Text(
                user?.phoneNumber ?? "Empty",
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            GlobalTextField(
              hintText: "Display Name",
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              textAlign: TextAlign.start,
              controller: context.read<ProfileProvider>().nameController,
            ),
            TextButton(
              onPressed: () {
                context.read<ProfileProvider>().updateUsername(context);
              },
              child: const Text("Update name"),
            ),
            GlobalTextField(
              hintText: "Email Update",
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              textAlign: TextAlign.start,
              controller: context.read<ProfileProvider>().emailController,
            ),
            TextButton(
              onPressed: () {
                context.read<ProfileProvider>().updateEmail(context);
              },
              child: const Text("Update email"),
            ),
            TextButton(
              onPressed: () {
                context.read<ProfileProvider>().updateUserImage(context,
                    "https://cdn-icons-png.flaticon.com/512/3135/3135715.png");
              },
              child: const Text("Update profile image"),
            ),
          ],
        ),
      ),
    );
  }
}
