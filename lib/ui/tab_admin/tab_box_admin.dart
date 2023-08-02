import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:texno_bozor/providers/auth_provider.dart';
import 'package:texno_bozor/ui/tab_admin/categories/categories_screen_admin.dart';
import 'package:texno_bozor/ui/tab_admin/products/products_screen_admin.dart';
import 'package:texno_bozor/ui/tab_admin/profile/profile_screen_admin.dart';

class TabBoxAdmin extends StatefulWidget {
  const TabBoxAdmin({super.key});

  @override
  State<TabBoxAdmin> createState() => _TabBoxAdminState();
}

class _TabBoxAdminState extends State<TabBoxAdmin> {
  List<Widget> screens = [];

  int currentIndex = 0;

  @override
  void initState() {
    screens = [
      ProductsScreenAdmin(),
      CategoriesScreenAdmin(),
      ProfileScreenAdmin(),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color:Color(0xFF4F8962),
        buttonBackgroundColor: Color(0xFF4F8962),
        height: 75,
        items: const <Widget>[
          Icon(Icons.device_hub, size: 30, color: Colors.white),
          Icon(Icons.category_outlined, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
