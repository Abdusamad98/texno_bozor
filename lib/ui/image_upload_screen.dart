import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:texno_bozor/view_model/image_upload_provider.dart';

class ImageUploadScreen extends StatefulWidget {
  const ImageUploadScreen({super.key});

  @override
  State<ImageUploadScreen> createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: Column(
        children: [
          ListTile(
            onTap: () async {
              XFile? xFile = await picker.pickImage(source: ImageSource.camera);
              if (xFile != null) {
                context.read<ImageUploadProvider>().uploadImage(file: xFile);
              }
            },
            title: Text("Camera"),
          ),
          ListTile(
            onTap: () async {
              XFile? xFile =
                  await picker.pickImage(source: ImageSource.gallery);
              if (xFile != null) {
                context.read<ImageUploadProvider>().uploadImage(file: xFile);
              }
            },
            title: Text("Gallery"),
          ),
          if (context.watch<ImageUploadProvider>().imageUrl.isNotEmpty)
            Image.network(
              context.watch<ImageUploadProvider>().imageUrl,
              width: 250,
              height: 200,
            ),
          if (context.watch<ImageUploadProvider>().isLoading)
            const Center(child: CircularProgressIndicator())
        ],
      ),
    );
  }
}
