import 'package:flutter/material.dart';


class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Web View"),),
      body: Column(children: [
        SizedBox(
          height: 200,
          width: double.infinity,
          child: Text(""),
        )
      ],),
    );
  }
}
