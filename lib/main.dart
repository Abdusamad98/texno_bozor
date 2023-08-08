
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:texno_bozor/services/local_notification_service.dart';
import 'package:texno_bozor/ui/news_screen.dart';
import 'package:texno_bozor/view_model/news_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //await initFirebase();
  await LocalNotificationService.instance.setupFlutterNotifications();

  runApp(
    ChangeNotifierProvider(
      create: (context) => NewsProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: child,
          theme: ThemeData.dark(),
        );
      },
      child: NewsScreen(),
    );
  }
}
