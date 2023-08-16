import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:texno_bozor/data/models/universal_data.dart';
import 'package:texno_bozor/utils/constants/constants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // DIO SETTINGS

  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        "Content-Type": "application/json",
        "Authorization": apiKey,
      },
      connectTimeout: Duration(seconds: TimeOutConstants.connectTimeout),
      receiveTimeout: Duration(seconds: TimeOutConstants.receiveTimeout),
      sendTimeout: Duration(seconds: TimeOutConstants.sendTimeout),
    ),
  );

  ApiService() {
    _init();
  }

  _init() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          //error.response.statusCode
          debugPrint("ERRORGA KIRDI:${error.message} and ${error.response}");
          return handler.next(error);
        },
        onRequest: (requestOptions, handler) async {
          debugPrint("SO'ROV  YUBORILDI :${handler.isCompleted}");
          // return handler.resolve(Response(requestOptions: requestOptions, data: {"name": "ali", "age": 26}));
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) async {
          debugPrint("JAVOB  KELDI :${handler.isCompleted}");
          return handler.next(response);
        },
      ),
    );
  }

  Future<UniversalData> sendMessage() async {
    Response response;
    try {
      response = await dio.post(
        '/fcm/send',
        data: {
          "to": "/topics/news",
          "notification": {
            "title": "NEWS APP",
            "body": "YANGILIKLAR QO'SHILDI"
          },
          "data": {
            "newsTitle":
                "«Tezkor qarshi hujum umidlari o‘ta optimistik bo‘lib chiqdi»",
            "newsBody":
                "Ukraina milliy xavfsizlik va mudofaa kengashi kotibi Oleksiy Danilov 2 avgust kuni qarshi hujum asnosida Ukraina harbiylarida dedlayn yoki grafik yo‘qligini ta’kidlagan. Uning so‘zlariga ko‘ra, Rossiya egallab olgan hududlarni ozod qilish yoppa minalashtirish tufayli qiyinlashmoqda, voqealar rivoji sekin ekanidan norozilar «urush nima ekanini tushunishmaydi».Danilovning so‘zlari G‘arbda Ukraina qurolli kuchlarining frontdagi harakatlaridan norozilik kuchayib borayotgan bir paytda yangradi. Uzoq kutilgan qarshi hujum kutilmalarni oqlayotgani yo‘q, biroq G‘arb OAVda qayd etilishicha, bunga bir qator obektiv sabablar bor. Bu sabablarni harbiy ekspertlar tobora faol muhokama qilishmoqda, o‘z sirtqi muloqotlarida ular ukrainaliklarning qarshi hujum operatsiyalarini tanqid ostiga ham olishmoqda, ba’zida esa frontdagi murakkabliklar e’tiboridan, oqlab ham qo‘yishmoqda.Quyida G‘arb matbuoti sharhida tahlilchilar Ukraina qurolli kuchlarining qanday muammolarga duchor bo‘layotgani haqida so‘z yuritayotgani, frontning old chizig‘idagi so‘nggi voqealar nega Ikkinchi jahon urushida ittifoqchilarning Normandiyaga tushirilishiga mengzalayotgani haqida hikoya qilamiz.",
            "newsDataImg":
                "https://storage.kun.uz/source/9/3niYZQI_Ble_Yx9xgMOFNS3m_wzpwIGy.jpg",
            "screen_name": "news"
          },
        },
      );

      if (response.statusCode == 200) {
        return UniversalData(data: response.data["message_id"]);
      }
      return UniversalData(error: "Other Error");
    } on DioException catch (e) {
      if (e.response != null) {
        return UniversalData(error: e.response!.data);
      } else {
        return UniversalData(error: e.message!);
      }
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> uploadImage({required XFile file}) async {
    Uri uri = Uri.https(
      "bozormedia.uz",
      "/services/mobile-seller/api/client-image-upload",
    );
    String fileName = file.path.split('/').last;

    var request = http.MultipartRequest('POST', uri);
    try {
      request.headers.addAll({
        "Accept": "multipart/form-data",
        "Authorization": token,
      });
      request.files.add(
        await http.MultipartFile.fromPath(
          "image",
          file.path,
          filename: fileName,
        ).timeout(const Duration(seconds: 30)),
      );

      var response = await request.send();
      debugPrint('${uri.path} :${response.statusCode}');

      if (response.statusCode == HttpStatus.ok) {
        var responseString = await response.stream.bytesToString();
        var result = jsonDecode(responseString);
        return UniversalData(data: result['url']);
      }
      return UniversalData(error: response.statusCode.toString());
    } on SocketException {
      return UniversalData(error: "Internet Error!");
    } on FormatException {
      return UniversalData(error: "Format Error!");
    } catch (err) {
      return UniversalData(error: err.toString());
    }
  }
}
