import 'package:flutter/cupertino.dart';
import 'package:texno_bozor/data/local_db.dart';
import 'package:texno_bozor/data/models/news/news_model.dart';
import 'package:texno_bozor/data/models/universal_data.dart';
import 'package:texno_bozor/data/network/api_service.dart';

class NewsProvider with ChangeNotifier {
  NewsProvider({required this.apiService}) {
    readNews();
  }

  final ApiService apiService;

  List<NewsModel> news = [];

  readNews() async {
    news = await LocalDatabase.getAllNews();
    debugPrint("NEWS READ: ${news.length}");
    notifyListeners();
  }

  deleteAllNews() async {
    await LocalDatabase.deleteAllNews();
    notifyListeners();
  }

  sendNews() async {
    UniversalData data = await apiService.sendMessage();
    if (data.error.isEmpty) {
      debugPrint("MESSAGE ID:${data.data}");
    } else {
      debugPrint("NEWS SEND ERROR:${data.error}");
    }
  }
}
