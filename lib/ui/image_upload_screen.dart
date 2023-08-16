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
              List<XFile> images = await picker.pickMultiImage();
              if (images.isNotEmpty) {
                if (context.mounted) {
                  context
                      .read<ImageUploadProvider>()
                      .uploadImages(images: images);
                }
              }
            },
            title: const Text("Gallery"),
          ),
          if (context.watch<ImageUploadProvider>().imageUrls.isNotEmpty)
            Image.network(
              context.watch<ImageUploadProvider>().imageUrls[0],
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
