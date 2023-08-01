import 'package:flutter/material.dart';
import 'package:texno_bozor/data/models/category/category_model.dart';


class CategoryItemView extends StatelessWidget {
  const CategoryItemView({super.key, required this.categoryModel, required this.onTap, required this.selectedId});

  final CategoryModel categoryModel;
  final VoidCallback onTap;
  final String selectedId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: selectedId ==
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
              color: selectedId ==
                  categoryModel.categoryId
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
