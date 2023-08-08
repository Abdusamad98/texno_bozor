class NewsModelFields{
  static const String id="id";
  static const String newsTitle="newsTitle";
  static const String newsBody="newsBody";
  static const String newsDataTitle="newsDataTitle";
  static const String newsDataBody="newsDataBody";
  static const String newsDataImg="newsDataImg";
  static const String newsDataDatetime="newsDataDatetime";

  static const String newsTable = "newstable";
}

class NewsModel {
  int? id;
  String newsTitle;
  String newsBody;
  String newsDataTitle;
  String newsDataBody;
  String newsDataImg;
  String newsDataDatetime;

  NewsModel({
    this.id,
    required this.newsTitle,
    required this.newsBody,
    required this.newsDataTitle,
    required this.newsDataBody,
    required this.newsDataImg,
    required this.newsDataDatetime,
  });

  NewsModel copyWith({
    String? newsTitle,
    String? newsBody,
    String? newsDataTitle,
    String? newsDataBody,
    String? newsDataImg,
    String? newsDataDatetime,
    int? id,
  }) {
    return NewsModel(
      newsTitle: newsTitle ?? this.newsTitle,
      newsBody: newsBody ?? this.newsBody,
      newsDataTitle: newsDataTitle ?? this.newsDataTitle,
      newsDataBody: newsDataBody ?? this.newsDataBody,
      newsDataImg: newsDataImg ?? this.newsDataImg,
      newsDataDatetime: newsDataDatetime ?? this.newsDataDatetime,
      id: id ?? this.id,
    );
  }

  factory NewsModel.fromJson(Map<String, dynamic> jsonData) {
    return NewsModel(
      id: jsonData[NewsModelFields.id] ?? 0,
      newsTitle: jsonData['newsTitle'] as String? ?? "",
      newsBody: jsonData['newsBody'] as String? ?? '',
      newsDataTitle: jsonData['newsDataTitle'] as String? ?? '',
      newsDataBody: jsonData['newsDataBody'] as String? ?? '',
      newsDataImg: jsonData['newsDataImg'] as String? ?? '',
      newsDataDatetime: jsonData['newsDataDatetime'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'newsTitle': newsTitle,
      'id': id,
      'newsBody': newsBody,
      'newsDataTitle': newsDataTitle,
      'newsDataBody': newsDataBody,
      'newsDataImg': newsDataImg,
      'newsDataDatetime': newsDataDatetime,
    };
  }

  @override
  String toString() {
    return ''''
       newsTitle : $newsTitle,
       newsBody : $newsBody,
       newsDataTitle : $newsDataTitle,
       newsDataBody : $newsDataBody,
       newsDataImg : $newsDataImg, 
       newsDataDatetime : $newsDataDatetime, 
       id: $id, 
      ''';
  }
}