import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:texno_bozor/data/firebase/category_service.dart';
import 'package:texno_bozor/data/firebase/prodycts_service.dart';
import 'package:texno_bozor/data/models/category/category_model.dart';
import 'package:texno_bozor/data/models/product/product_model.dart';
import 'package:texno_bozor/data/models/universal_data.dart';
import 'package:texno_bozor/utils/ui_utils/loading_dialog.dart';

class ProductsProvider with ChangeNotifier {
  ProductsProvider({required this.productsService});

  final ProductsService productsService;

  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productDescController = TextEditingController();
  TextEditingController productCountController = TextEditingController();



  Future<void> addProduct({
    required BuildContext context,
    required String categoryId,
    required String productCurrency,
    required List<String> imageUrls,
  }) async {
    String name = productNameController.text;
    String productDesc = productDescController.text;
    String priceText = productPriceController.text;
    String countText = productCountController.text;

    if (name.isNotEmpty &&
        productDesc.isNotEmpty &&
        priceText.isNotEmpty &&
        countText.isNotEmpty) {
      ProductModel productModel = ProductModel(
        count: int.parse(countText),
        price: int.parse(priceText),
        productImages: imageUrls,
        categoryId: categoryId,
        productId: "",
        productName: name,
        description: productDesc,
        createdAt: DateTime.now().toString(),
        currency: productCurrency,
      );

      showLoading(context: context);
      UniversalData universalData =
          await productsService.addProduct(productModel: productModel);
      if (context.mounted) {
        hideLoading(dialogContext: context);
      }
      if (universalData.error.isEmpty) {
        if (context.mounted) {
          showMessage(context, universalData.data as String);
          clearTexts();
          Navigator.pop(context);
        }
      } else {
        if (context.mounted) {
          showMessage(context, universalData.error);
        }
      }
    } else {
      showMessage(context, "Maydonlar to'liq emas!!!");
    }
  }

  Future<void> deleteProduct({
    required BuildContext context,
    required String productId,
  }) async {
    showLoading(context: context);
    UniversalData universalData =
        await productsService.deleteProduct(productId: productId);
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

  Stream<List<ProductModel>> getProducts(String categoryId) async* {
    if (categoryId.isEmpty) {
      yield* FirebaseFirestore.instance.collection("products").snapshots().map(
            (event1) => event1.docs
                .map((doc) => ProductModel.fromJson(doc.data()))
                .toList(),
          );
    } else {
      yield* FirebaseFirestore.instance
          .collection("products")
          .where("categoryId", isEqualTo: categoryId)
          .snapshots()
          .map(
            (event1) => event1.docs
                .map((doc) => ProductModel.fromJson(doc.data()))
                .toList(),
          );
    }
  }

  showMessage(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    notifyListeners();
  }

  Future<void> updateProduct({
    required BuildContext context,
    required String imagePath,
    required ProductModel productModel,
  }) async {
    String name = productNameController.text;
    String categoryDesc = productPriceController.text;

    if (name.isNotEmpty && categoryDesc.isNotEmpty) {
      showLoading(context: context);
      UniversalData universalData = await productsService.updateProduct(
        productModel: ProductModel(
          count: 1,
          price: 23,
          productImages: [],
          categoryId: productModel.categoryId,
          createdAt: productModel.createdAt,
          productName: productNameController.text,
          description: productPriceController.text,
          productId: productModel.productId,
          currency: "SO'M",
        ),
      );
      if (context.mounted) {
        hideLoading(dialogContext: context);
      }
      if (universalData.error.isEmpty) {
        if (context.mounted) {
          showMessage(context, universalData.data as String);
          clearTexts();
          Navigator.pop(context);
        }
      } else {
        if (context.mounted) {
          showMessage(context, universalData.error);
        }
      }
    }
  }









  setInitialValues(CategoryModel categoryModel) {
    productNameController =
        TextEditingController(text: categoryModel.categoryName);
    productPriceController =
        TextEditingController(text: categoryModel.description);
    notifyListeners();
  }

  clearTexts() {
    productPriceController.clear();
    productNameController.clear();
    productDescController.clear();
    productCountController.clear();
  }
}
