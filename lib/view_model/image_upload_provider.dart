import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:texno_bozor/data/models/universal_data.dart';
import 'package:texno_bozor/data/network/api_service.dart';

class ImageUploadProvider with ChangeNotifier {
  ImageUploadProvider({required this.apiService});

  final ApiService apiService;

  String imageUrl = "";

  bool isLoading = false;

  uploadImage({required XFile file}) async {
    isLoading = true;
    notifyListeners();
    UniversalData data = await apiService.uploadImage(file: file);
    if (data.error.isEmpty) {
      debugPrint("UPLOADED LINK :${data.data}");
      imageUrl = "https://bozormedia.uz/${data.data}";
    } else {
      debugPrint("UPLOADED LINK ERROR:${data.error}");
    }
    isLoading = false;
    notifyListeners();
  }
}
