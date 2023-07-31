import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:texno_bozor/data/models/category/category_model.dart';
import 'package:texno_bozor/providers/category_provider.dart';

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
        title: Text("Products Clinet"),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView(
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
                            child: Expanded(
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
                                          borderRadius: BorderRadius.circular(4),
                                          color: selectedCategoryId ==
                                                  categoryModel.categoryId
                                              ? Colors.green
                                              : Colors.white,
                                        ),
                                        height: 50,
                                        margin: const EdgeInsets.all(5),
                                        padding: const EdgeInsets.all(10),
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
            ],
          ))
        ],
      ),
    );
  }
}
