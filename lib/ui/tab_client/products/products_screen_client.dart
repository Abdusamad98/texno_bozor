import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:texno_bozor/data/models/category/category_model.dart';
import 'package:texno_bozor/data/models/product/product_model.dart';
import 'package:texno_bozor/providers/category_provider.dart';
import 'package:texno_bozor/providers/products_provider.dart';
import 'package:texno_bozor/ui/tab_client/products/widgets/category_item_view.dart';
import 'package:texno_bozor/ui/tab_client/products/widgets/product_detail.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String selectedCategoryId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products Client"),
      ),
      body: Column(
        children: [
          StreamBuilder<List<CategoryModel>>(
            stream: context.read<CategoryProvider>().getCategories(),
            builder: (BuildContext context,
                AsyncSnapshot<List<CategoryModel>> snapshot) {
              if (snapshot.hasData) {
                return snapshot.data!.isNotEmpty
                    ? SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            CategoryItemView(
                              categoryModel: CategoryModel(
                                categoryId: "",
                                description: "",
                                categoryName: "All",
                                imageUrl: "",
                                createdAt: "",
                              ),
                              onTap: () {
                                setState(() {
                                  selectedCategoryId = "";
                                });
                              },
                              selectedId: selectedCategoryId,
                            ),
                            ...List.generate(
                              snapshot.data!.length,
                              (index) {
                                CategoryModel categoryModel =
                                    snapshot.data![index];
                                return CategoryItemView(
                                  categoryModel: categoryModel,
                                  onTap: () {
                                    setState(() {
                                      selectedCategoryId =
                                          categoryModel.categoryId;
                                    });
                                  },
                                  selectedId: selectedCategoryId,
                                );
                              },
                            )
                          ],
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
          StreamBuilder<List<ProductModel>>(
            stream: context
                .read<ProductsProvider>()
                .getProducts(selectedCategoryId),
            builder: (BuildContext context,
                AsyncSnapshot<List<ProductModel>> snapshot) {
              if (snapshot.hasData) {
                return snapshot.data!.isNotEmpty
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: StreamBuilder<List<ProductModel>>(
                            stream: context
                                .read<ProductsProvider>()
                                .getProducts(selectedCategoryId),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<ProductModel>> snapshot) {
                              if (snapshot.hasData) {
                                return snapshot.data!.isNotEmpty
                                    ? Expanded(
                                        child: GridView(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                mainAxisSpacing: 10,
                                                crossAxisSpacing: 10,
                                                childAspectRatio: 0.6),
                                        children: [
                                          ...List.generate(
                                              snapshot.data!.length, (index) {
                                            ProductModel productModel =
                                                snapshot.data![index];
                                            return ZoomTapAnimation(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductDetailScreen(
                                                      productModel:
                                                          productModel,
                                                      index: index,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    color: Colors.blue
                                                        .withOpacity(0.8)),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Hero(
                                                      tag: index,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                        child:
                                                            CachedNetworkImage(
                                                          height: 100,
                                                          width: 100,
                                                          imageUrl: productModel
                                                              .productImages
                                                              .first,
                                                          placeholder: (context,
                                                                  url) =>
                                                              const CupertinoActivityIndicator(),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              const Icon(
                                                                  Icons.error),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          productModel
                                                              .productName,
                                                          style: TextStyle(
                                                              fontSize: 22,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                        SizedBox(height: 10),
                                                        Text(
                                                          productModel
                                                              .description,
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        SizedBox(height: 10),
                                                        Text(
                                                          "Price: ${productModel.price} ${productModel.currency}",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        SizedBox(height: 10),
                                                        Text(
                                                          "Count: ${productModel.count}",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          })
                                        ],
                                      ))
                                    : const Center(
                                        child: Text(
                                          "Product Empty!",
                                          style: TextStyle(
                                              fontSize: 32,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      );
                              }
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text(snapshot.error.toString()),
                                );
                              }
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          ),
                        ),
                      )
                    : const Center(child: Text("Product Empty!"));
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
