import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:texno_bozor/providers/auth_provider.dart';
import 'package:texno_bozor/ui/tab/categories/categories_screen.dart';
import 'package:texno_bozor/ui/tab/products/products_screen.dart';
import 'package:texno_bozor/ui/tab/profile/profile_screen.dart';

class TabBox extends StatefulWidget {
  const TabBox({super.key});

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  List<Widget> screens = [];

  int currentIndex = 0;

  @override
  void initState() {
    screens = [
      ProductsScreen(),
      CategoriesScreen(),
      ProfileScreen(),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.shop_two), label: "Products"),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: "Catgeories"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
