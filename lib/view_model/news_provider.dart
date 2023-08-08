import 'package:flutter/cupertino.dart';
import 'package:texno_bozor/data/local_db.dart';
import 'package:texno_bozor/data/models/news/news_model.dart';

class NewsProvider with ChangeNotifier {
  List<NewsModel> news = [];

  NewsProvider() {
    readNews();
  }

  readNews() async {
    news = await LocalDatabase.getAllNews();
    debugPrint("NEWS READ: ${news.length}");
    notifyListeners();
  }

}
