import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:texno_bozor/data/network/api_service.dart';

import 'package:texno_bozor/services/local_notification_service.dart';
import 'package:texno_bozor/ui/image_upload_screen.dart';
import 'package:texno_bozor/ui/news_screen.dart';
import 'package:texno_bozor/view_model/image_upload_provider.dart';
import 'package:texno_bozor/view_model/news_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalNotificationService.instance.setupFlutterNotifications();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ImageUploadProvider(apiService: ApiService()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImageUploadScreen(),
      theme: ThemeData.dark(),
    );
  }
}
