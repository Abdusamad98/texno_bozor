import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:texno_bozor/providers/auth_provider.dart';
import 'package:texno_bozor/providers/profiles_provider.dart';
import 'package:texno_bozor/ui/auth/widgets/global_text_fields.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: ListView(
                children: [
                  Image.network(user?.photoURL ?? ""),
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
                      context
                          .read<ProfileProvider>()
                          .updateUserDisplayName(context);
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
                  )
                ],
              ),
            ),
            Visibility(
              visible: context.watch<ProfileProvider>().isLoading,
              child: const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ));
  }
}
