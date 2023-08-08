class NewsModelFields {
  static const String id = "id";
  static const String newsTitle = "newsTitle";
  static const String newsBody = "newsBody";
  static const String newsDataTitle = "newsDataTitle";
  static const String newsDataBody = "newsDataBody";
  static const String newsDataImg = "newsDataImg";
  static const String newsDataDatetime = "newsDataDatetime";

  static const String newsTable = "newstable";
}

class NewsModel {
  int? id;
  String newsTitle;
  String newsBody;

  String newsDataImg;

  NewsModel({
    this.id,
    required this.newsTitle,
    required this.newsBody,
    required this.newsDataImg,
  });

  NewsModel copyWith({
    String? newsTitle,
    String? newsBody,
    String? newsDataImg,
    int? id,
  }) {
    return NewsModel(
      newsTitle: newsTitle ?? this.newsTitle,
      newsBody: newsBody ?? this.newsBody,
      newsDataImg: newsDataImg ?? this.newsDataImg,
      id: id ?? this.id,
    );
  }

  factory NewsModel.fromJson(Map<String, dynamic> jsonData) {
    return NewsModel(
      id: jsonData[NewsModelFields.id] ?? 0,
      newsTitle: jsonData['newsTitle'] as String? ?? "",
      newsBody: jsonData['newsBody'] as String? ?? '',
      newsDataImg: jsonData['newsDataImg'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'newsTitle': newsTitle,
      'newsBody': newsBody,
      'newsDataImg': newsDataImg,
    };
  }

  @override
  String toString() {
    return ''''
       newsTitle : $newsTitle,
       newsBody : $newsBody,
       newsDataImg : $newsDataImg, 
       id: $id, 
      ''';
  }
}
