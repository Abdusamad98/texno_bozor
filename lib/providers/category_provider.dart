import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:texno_bozor/data/firebase/category_service.dart';
import 'package:texno_bozor/data/models/category/category_model.dart';
import 'package:texno_bozor/data/models/universal_data.dart';
import 'package:texno_bozor/utils/ui_utils/loading_dialog.dart';

class CategoryProvider with ChangeNotifier {
  CategoryProvider({required this.categoryService});

  final CategoryService categoryService;

  Future<void> addCategory({
    required BuildContext context,
    required CategoryModel categoryModel,
  }) async {
    showLoading(context: context);
    UniversalData universalData =
        await categoryService.addCategory(categoryModel: categoryModel);
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showMessage(context, universalData.data as String);
      }
    } else {
      if (context.mounted) {
        showMessage(context, universalData.error);
      }
    }
  }

  Future<void> updateCategory({
    required BuildContext context,
    required CategoryModel categoryModel,
  }) async {
    showLoading(context: context);
    UniversalData universalData =
        await categoryService.updateCategory(categoryModel: categoryModel);
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showMessage(context, universalData.data as String);
      }
    } else {
      if (context.mounted) {
        showMessage(context, universalData.error);
      }
    }
  }

  Future<void> deleteCategory({
    required BuildContext context,
    required String categoryId,
  }) async {
    showLoading(context: context);
    UniversalData universalData =
        await categoryService.deleteCategory(categoryId: categoryId);
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showMessage(context, universalData.data as String);
      }
    } else {
      if (context.mounted) {
        showMessage(context, universalData.error);
      }
    }
  }

  Stream<List<CategoryModel>> getCategories() =>
      FirebaseFirestore.instance.collection("categories").snapshots().map(
            (event1) => event1.docs
                .map((doc) => CategoryModel.fromJson(doc.data()))
                .toList(),
          );

  showMessage(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    notifyListeners();
  }
}
