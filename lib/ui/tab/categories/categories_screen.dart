import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:texno_bozor/data/models/category/category_model.dart';
import 'package:texno_bozor/providers/category_provider.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
        actions: [
          IconButton(
            onPressed: () {
              context.read<CategoryProvider>().addCategory(
                    context: context,
                    categoryModel: CategoryModel(
                      categoryId: "",
                      categoryName: "Planshetlar",
                      description: "Zo'r telefonlar",
                      imageUrl: "imageUrl",
                      createdAt: DateTime.now().toString(),
                    ),
                  );
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: StreamBuilder<List<CategoryModel>>(
        stream: context.read<CategoryProvider>().getCategories(),
        builder: (BuildContext context,
            AsyncSnapshot<List<CategoryModel>> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isNotEmpty
                ? ListView(
                    children: List.generate(
                      snapshot.data!.length,
                      (index) {
                        CategoryModel categoryModel = snapshot.data![index];
                        return ListTile(
                          onLongPress: () {
                            context.read<CategoryProvider>().deleteCategory(
                                  context: context,
                                  categoryId: categoryModel.categoryId,
                                );
                          },
                          title: Text(categoryModel.categoryName),
                          subtitle: Text(categoryModel.description),
                          trailing: IconButton(
                            onPressed: () {
                              context.read<CategoryProvider>().updateCategory(
                                    context: context,
                                    categoryModel: CategoryModel(
                                      categoryId: categoryModel.categoryId,
                                      categoryName: "Planshetlar zo'ridan",
                                      description: "Zo'r telefonlar zo'ridan",
                                      imageUrl: "imageUrl",
                                      createdAt: DateTime.now().toString(),
                                    ),
                                  );
                            },
                            icon: const Icon(Icons.edit),
                          ),
                        );
                      },
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
    );
  }
}
