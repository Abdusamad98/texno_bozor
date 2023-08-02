import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:texno_bozor/data/models/category/category_model.dart';
import 'package:texno_bozor/data/models/product/product_model.dart';
import 'package:texno_bozor/providers/category_provider.dart';
import 'package:texno_bozor/providers/products_provider.dart';
import 'package:texno_bozor/ui/auth/widgets/global_button.dart';
import 'package:texno_bozor/ui/auth/widgets/global_text_fields.dart';
import 'package:texno_bozor/utils/colors/app_colors.dart';
import 'package:texno_bozor/utils/constants.dart';

class ProductAddScreen extends StatefulWidget {
  ProductAddScreen({super.key, this.productModel});

  ProductModel? productModel;

  @override
  State<ProductAddScreen> createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  ImagePicker picker = ImagePicker();
  String currency = "";

  List<String> currencies = ["UZS", "USD", "RUB"];

  String selectedCurrency = "UZS";
  String selectedCategoryId = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<ProductsProvider>(context, listen: false).clearParameters();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              widget.productModel == null ? "Product Add" : "Product Update"),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Provider.of<CategoryProvider>(context, listen: false)
                  .clearTexts();
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  GlobalTextField(
                      hintText: "Product Name",
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.start,
                      controller: context
                          .read<ProductsProvider>()
                          .productNameController),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 200,
                    child: GlobalTextField(
                        maxLine: 100,
                        hintText: "Description",
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textAlign: TextAlign.start,
                        controller: context
                            .read<ProductsProvider>()
                            .productDescController),
                  ),
                  const SizedBox(height: 24),
                  GlobalTextField(
                    hintText: "Product Count",
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.start,
                    controller:
                        context.read<ProductsProvider>().productCountController,
                  ),
                  const SizedBox(height: 24),
                  GlobalTextField(
                    hintText: "Product Price",
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.start,
                    controller:
                        context.read<ProductsProvider>().productPriceController,
                  ),
                  const SizedBox(height: 24),
                  DropdownButton(
                    // Initial Value
                    value: selectedCurrency,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: currencies.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCurrency = newValue!;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  StreamBuilder<List<CategoryModel>>(
                    stream: context.read<CategoryProvider>().getCategories(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<CategoryModel>> snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data!.isNotEmpty
                            ? SizedBox(
                                height: 100,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: List.generate(
                                    snapshot.data!.length,
                                    (index) {
                                      CategoryModel categoryModel =
                                          snapshot.data![index];
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedCategoryId =
                                                categoryModel.categoryId;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            color: selectedCategoryId ==
                                                    categoryModel.categoryId
                                                ? Colors.green
                                                : Colors.white,
                                          ),
                                          height: 100,
                                          margin: const EdgeInsets.all(16),
                                          padding: const EdgeInsets.all(16),
                                          child: Center(
                                            child: Text(
                                              categoryModel.categoryName,
                                              style: TextStyle(
                                                color: selectedCategoryId ==
                                                        categoryModel.categoryId
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : const Center(child: Text("Empty!"));
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                  const SizedBox(height: 24),
                  context.watch<ProductsProvider>().uploadedImagesUrls.isEmpty
                      ? TextButton(
                          onPressed: () {
                            showBottomSheetDialog();
                          },
                          style: TextButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).indicatorColor),
                          child: const Text(
                            "Select Image",
                            style: TextStyle(color: Colors.black),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      : SizedBox(
                          height: 100,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              ...List.generate(
                                  context
                                      .watch<ProductsProvider>()
                                      .uploadedImagesUrls
                                      .length, (index) {
                                String singleImage = context
                                    .watch<ProductsProvider>()
                                    .uploadedImagesUrls[index];
                                return Container(
                                  padding: const EdgeInsets.all(5),
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Image.network(
                                    singleImage,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.fill,
                                  ),
                                );
                              })
                            ],
                          ),
                        ),

                  Visibility(
                    visible: context.watch<ProductsProvider>().uploadedImagesUrls.isNotEmpty,
                    child: TextButton(
                    onPressed: () {
                      showBottomSheetDialog();
                    },
                    style: TextButton.styleFrom(
                        backgroundColor:
                        Theme.of(context).indicatorColor),
                    child: const Text(
                      "Select Image",
                      style: TextStyle(color: Colors.black),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),),

                  const SizedBox(height: 24),
                ],
              ),
            ),
            GlobalButton(
                title: widget.productModel == null
                    ? "Add product"
                    : "Update product",
                onTap: () {
                  if (context
                          .read<ProductsProvider>()
                          .uploadedImagesUrls
                          .isNotEmpty &&
                      selectedCategoryId.isNotEmpty) {
                    context.read<ProductsProvider>().addProduct(
                          context: context,
                          categoryId: selectedCategoryId,
                          productCurrency: selectedCurrency,
                        );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(milliseconds: 500),
                        backgroundColor: Colors.red,
                        margin: EdgeInsets.symmetric(
                          vertical: 100,
                          horizontal: 20,
                        ),
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                          "Ma'lumotlar to'liq emas!!!",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }

  void showBottomSheetDialog() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24),
          height: 200,
          decoration: BoxDecoration(
            color: AppColors.c_162023,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  _getFromGallery();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.photo),
                title: const Text("Select from Gallery"),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _getFromGallery() async {
    List<XFile> xFiles = await picker.pickMultiImage(
      maxHeight: 512,
      maxWidth: 512,
    );
    await Provider.of<ProductsProvider>(context, listen: false)
        .uploadProductImages(
      context: context,
      images: xFiles,
    );
  }
}
