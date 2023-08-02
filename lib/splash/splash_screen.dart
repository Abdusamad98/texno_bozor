import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:texno_bozor/app/app.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _init() async {
    await Future.delayed(const Duration(seconds: 3));

    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return App();
          },
        ),
      );
    }
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        Stack(
          children: [Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Row(
                children: [
                  Icon(Icons.shopping_cart,color: Color(0xFF4F8962),size: 100.sp,),
                  Text('Texno Bazar',style: TextStyle(color: Color(0xFF4F8962),fontSize: 40.sp,fontWeight: FontWeight.w900,fontFamily: 'DMSans'),)
                ],
              ),
            ),
          ),
            Positioned(
              top: -130,
                right: -60,
                child: Circle(height: 250, width: 250, color: Color(0xFF4F8962))),
            Positioned(
              top: 30,
                right: 220,
                child: Circle(height: 100, width: 100, color: Color(0xFF4F8962).withOpacity(0.85))),
            Positioned(
              bottom: -130,
                left: -60,
                child: Circle(height: 250, width: 250, color: Color(0xFF4F8962))),
            Positioned(
              bottom: 30,
                left: 220,
                child: Circle(height: 100, width: 100, color: Color(0xFF4F8962).withOpacity(0.85))),
          ],
        ),
          backgroundColor: Colors.white,
    );
  }
}



class Circle extends StatelessWidget {
  const Circle({super.key, required this.height, required this.width, required this.color});
  final double height;
  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(height),color: color),
    );
  }
}
