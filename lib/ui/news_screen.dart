import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:texno_bozor/data/models/news/news_model.dart';
import 'package:texno_bozor/services/fcm.dart';
import 'package:texno_bozor/view_model/news_provider.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    initFirebase(context);
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News"),
        actions: [
          TextButton(onPressed: () {
            FirebaseMessaging.instance.unsubscribeFromTopic("news");
            //FirebaseMessaging.instance.subscribeToTopic("flutter_news");
          }, child: Text("ON")),
        ],
      ),
      body: context.watch<NewsProvider>().news.isEmpty
          ? const Center(child: Text("EMPTY!!!"))
          : ListView(
              children: [
                ...List.generate(
                  context.watch<NewsProvider>().news.length,
                  (index) {
                    NewsModel newsModel =
                        context.watch<NewsProvider>().news[index];
                    return ListTile(
                      leading: Image.network(newsModel.newsDataImg),
                      title: Text(newsModel.newsTitle),
                      subtitle: Text(
                        newsModel.newsBody,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              ],
            ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        print('appLifeCycleState inactive');
        break;
      case AppLifecycleState.resumed:
        context.read<NewsProvider>().readNews();
        break;
      case AppLifecycleState.paused:
        print('appLifeCycleState paused');
        break;
      case AppLifecycleState.detached:
        print('appLifeCycleState suspending');
        break;
    }
  }
}
