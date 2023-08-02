import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:texno_bozor/providers/auth_provider.dart';
import 'package:texno_bozor/ui/tab_client/categories/categories_screen_client.dart';
import 'package:texno_bozor/ui/tab_client/orders/orders_screen_client.dart';
import 'package:texno_bozor/ui/tab_client/products/products_screen_client.dart';
import 'package:texno_bozor/ui/tab_client/profile/profile_screen_client.dart';

class TabBoxClient extends StatefulWidget {
  const TabBoxClient({super.key});

  @override
  State<TabBoxClient> createState() => _TabBoxClientState();
}

class _TabBoxClientState extends State<TabBoxClient> {
  List<Widget> screens = [];

  int currentIndex = 0;

  @override
  void initState() {
    screens = [
      ProductsScreen(),
      CategoriesScreen(),
      OrdersScreen(),
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
          BottomNavigationBarItem(icon: Icon(Icons.shop_two), label: "Products"),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "Catgeories"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_basket), label: "Orders"),
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
